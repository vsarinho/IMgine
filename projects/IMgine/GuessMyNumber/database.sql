
drop database if exists guess_my_number;
create database guess_my_number;

use guess_my_number;

-- GameConfig
DROP TABLE IF EXISTS GameConfig;
CREATE TABLE GameConfig (
	splashText VARCHAR(4000) CHARACTER SET 'utf8',
	splashPath VARCHAR(1000) CHARACTER SET 'utf8',
	aboutText VARCHAR(4000) CHARACTER SET 'utf8',
	aboutPath VARCHAR(1000) CHARACTER SET 'utf8'
) ENGINE=InnoDb DEFAULT CHARSET=utf8;

INSERT INTO GameConfig (splashText, aboutText)
VALUES ("Welcome to GuessMyNumberBot!! 

Please select an option:",
"This demo game was developed by prof. D.Sc. Victor Sarinho at UEFS - Brazil. Enjoy it.");


-- GameStatus
DROP TABLE IF EXISTS GameStatus;
CREATE TABLE GameStatus (
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	message VARCHAR(4000) CHARACTER SET 'utf8',
	imagePath VARCHAR(1000) CHARACTER SET 'utf8',
	promptText VARCHAR(2000) CHARACTER SET 'utf8',
	menuText VARCHAR(2000) CHARACTER SET 'utf8',
	option1 VARCHAR(80) CHARACTER SET 'utf8',
	option2 VARCHAR(80) CHARACTER SET 'utf8',
	option3 VARCHAR(80) CHARACTER SET 'utf8',
	option4 VARCHAR(80) CHARACTER SET 'utf8',
	score int,
	highScorePosition int,
	highScoreText VARCHAR(500) CHARACTER SET 'utf8',
	gameEndMessage VARCHAR(1000) CHARACTER SET 'utf8',
  PRIMARY KEY (jidClient)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Results;
CREATE TABLE Results (
	id int NOT NULL AUTO_INCREMENT,
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	score int,
	name VARCHAR(10) CHARACTER SET 'utf8',
	dateTime DATETIME,
  PRIMARY KEY (id)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS GamePlay;
CREATE TABLE GamePlay (
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	currentNumber int,
	minNumber int,
	maxNumber int,
	attempts int,
  PRIMARY KEY (jidClient)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS TempHighScore;
CREATE TABLE TempHighScore (
	id int NOT NULL AUTO_INCREMENT,
	position int,
	name VARCHAR(10) CHARACTER SET 'utf8',
	score int,
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
  PRIMARY KEY (id)
)ENGINE=MEMORY DEFAULT CHARSET=utf8;


delimiter //

-- startGameStatus
drop PROCEDURE if exists startGameStatus //
CREATE PROCEDURE startGameStatus(IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
								IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8')
BEGIN
	set @v_min := 1;
	set @v_max := 1000;

	replace into GameStatus (jidServer, jidClient, message, imagePath, promptText, menuText, option1, option2, option3, 
				option4, score, highScorePosition, highScoreText, gameEndMessage) 
	values (p_jidServer, p_jidClient, "", "", concat("Give me a number between ",@v_min," and ",@v_max,":"), 
		"", "", "", "", "", 0, 0, "", "");	

	replace into GamePlay(jidServer, jidClient, currentNumber, minNumber, maxNumber, attempts)
	values (p_jidServer, p_jidClient, floor(rand() * (@v_max - @v_min +1)) + @v_min, @v_min, @v_max, 0);
END //


-- updateGameStatus
drop PROCEDURE if exists updateGameStatus //
CREATE PROCEDURE updateGameStatus(IN p_command VARCHAR(5000) CHARACTER SET 'utf8', 
				IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
				IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8')
BEGIN
	DECLARE v_currentNumber INT DEFAULT 0;
	DECLARE v_minNumber INT DEFAULT 0;
	DECLARE v_maxNumber INT DEFAULT 0;
	DECLARE v_attempts INT DEFAULT 0;
	DECLARE v_suggestedNumber INT DEFAULT 0;
	DECLARE v_gameEndMessage VARCHAR(1000) CHARACTER SET 'utf8';
    DECLARE v_highScorePosition INT DEFAULT 0;
    DECLARE v_highScoreText VARCHAR(1000) CHARACTER SET 'utf8';

	select currentNumber, minNumber, maxNumber, attempts, (SELECT (CAST(p_command AS UNSIGNED))) 
	into v_currentNumber, v_minNumber, v_maxNumber, v_attempts, v_suggestedNumber
	from GamePlay
	where jidClient = p_jidClient and jidServer = p_jidServer;

	set v_attempts := v_attempts + 1;

	set v_gameEndMessage := '';
	if (v_suggestedNumber = v_currentNumber) then
		set v_gameEndMessage := concat("Congratulations!! You discovered my secret number in ",v_attempts," attempts!");

		insert into Results (jidServer, jidClient, score, dateTime)
		values (p_jidServer, p_jidClient, v_attempts, now());

		if (v_attempts = 1) then
			set v_highScorePosition := 1;
		else
			set v_highScorePosition := (select count(*)+1 from Results 
							where score <= v_attempts and name is not null);
		end if;

		set v_highScoreText := "Give a name to be included in highscore list:";
	end if;

	if (v_suggestedNumber > v_currentNumber and v_suggestedNumber < v_maxNumber) then
		set v_maxNumber := v_suggestedNumber;
	end if;

	if (v_suggestedNumber < v_currentNumber and v_suggestedNumber > v_minNumber) then
		set v_minNumber := v_suggestedNumber;
	end if;


	replace into GameStatus (jidServer, jidClient, message, imagePath, promptText, menuText, option1, option2, option3, 
				option4, score, highScorePosition, highScoreText, gameEndMessage) 
	values (p_jidServer, p_jidClient, "", "", concat(v_attempts+1,"? attempt! Give me a number between ",v_minNumber," and ",v_maxNumber,":"), 
		"", "", "", "", "", v_attempts, v_highScorePosition, v_highScoreText, v_gameEndMessage);	

	replace into GamePlay(jidServer, jidClient, currentNumber, minNumber, maxNumber, attempts)
	values (p_jidServer, p_jidClient, v_currentNumber, v_minNumber, v_maxNumber, v_attempts);
END //


-- storeHighScore
drop PROCEDURE if exists storeHighScore //
CREATE PROCEDURE storeHighScore(IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
				IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8',
				IN p_name VARCHAR(5000) CHARACTER SET 'utf8')
BEGIN
	update Results 
	set name = SUBSTRING(p_name, 1, 10)
	where jidServer = p_jidServer and jidClient = p_jidClient;
END // 


-- getHighScores
drop PROCEDURE if exists getHighScores //
CREATE PROCEDURE getHighScores(IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
							IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8')
BEGIN
	DECLARE v_result VARCHAR(5000) CHARACTER SET 'utf8';
	
	delete from TempHighScore where jidServer = p_jidServer and jidClient = p_jidClient;
	SET @cnt := 0;
	insert into TempHighScore (position, name, score, jidServer, jidClient)
	select @cnt := @cnt + 1, name, score, p_jidServer, p_jidClient
	FROM Results order by score, dateTime desc limit 5;
	
	SELECT group_concat(concat(C.position, ': ', C.name, ' - ', C.score) separator '\n')
	into v_result
	FROM (select * from TempHighScore where jidServer = p_jidServer and jidClient = p_jidClient order by id) C order by C.position;

	if (v_result is not null) then
		SELECT concat('### HighScores ###\n', v_result);
	else
		SELECT '### HighScores ###\n';
	end if;
END //

delimiter ;
