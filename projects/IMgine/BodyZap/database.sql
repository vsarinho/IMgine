
drop database if exists bodyzap;
create database bodyzap;

use bodyzap;

-- GameConfig
DROP TABLE IF EXISTS GameConfig;
CREATE TABLE GameConfig (
	splashText VARCHAR(4000) CHARACTER SET 'utf8',
	splashPath VARCHAR(1000) CHARACTER SET 'utf8',
	aboutText VARCHAR(4000) CHARACTER SET 'utf8',
	aboutPath VARCHAR(1000) CHARACTER SET 'utf8'
) ENGINE=InnoDb DEFAULT CHARSET=utf8;

INSERT INTO GameConfig (splashText, aboutText)
VALUES ("Olá!! Teste seus conhecimentos de fisiologia no BodyZap! 

Escolha uma opção:",
"Esta versão do jogo Body foi desenvolvida pelo prof. D.Sc. Victor Sarinho (UEFS - Brazil). Espero que vc goste.");


-- GameStatus
DROP TABLE IF EXISTS GameStatus;
CREATE TABLE GameStatus (
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	statusId VARCHAR(80) CHARACTER SET 'utf8',
	message VARCHAR(4000) CHARACTER SET 'utf8',
	imagePath VARCHAR(1000) CHARACTER SET 'utf8',
	httpText VARCHAR(2000) CHARACTER SET 'utf8',
	httpImage VARCHAR(2000) CHARACTER SET 'utf8',
	promptText VARCHAR(2000) CHARACTER SET 'utf8',
	menuText VARCHAR(2000) CHARACTER SET 'utf8',
	option1 VARCHAR(1000) CHARACTER SET 'utf8',
	option2 VARCHAR(1000) CHARACTER SET 'utf8',
	option3 VARCHAR(1000) CHARACTER SET 'utf8',
	option4 VARCHAR(1000) CHARACTER SET 'utf8',
	option5 VARCHAR(1000) CHARACTER SET 'utf8',
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
	startUp dateTime,
	attempts int,
	idLastCard int,
  PRIMARY KEY (jidClient)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS OrgaosConquistados;
CREATE TABLE OrgaosConquistados (
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	idOrgao int
)ENGINE=InnoDb DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Orgao;
CREATE TABLE Orgao (
	id int NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100) CHARACTER SET 'utf8',
	sistema VARCHAR(100) CHARACTER SET 'utf8',	
  PRIMARY KEY (id)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;


insert into Orgao (nome, sistema) values ("Estômago","digestório");
insert into Orgao (nome, sistema) values ("Fígado","digestório");
insert into Orgao (nome, sistema) values ("Intestino delgado","digestório");
insert into Orgao (nome, sistema) values ("Intestino grosso","digestório");
insert into Orgao (nome, sistema) values ("Apêndice","digestório");
-- insert into Orgao (nome, sistema) values ("Reto","digestório");

insert into Orgao (nome, sistema) values ("Faringe","respiratório");
insert into Orgao (nome, sistema) values ("Laringe","respiratório");
insert into Orgao (nome, sistema) values ("Traquéia","respiratório");
insert into Orgao (nome, sistema) values ("Brônquios","respiratório");
insert into Orgao (nome, sistema) values ("Pulmão","respiratório");
-- insert into Orgao (nome, sistema) values ("Bronquíolos","respiratório");


/*
Lobo Frontal – Lobo pariental e lobo temporal
Lobo pariental – Lobo frontal, lobo temporal e lobo occipital
Lobo temporal: Lobo frontal, lobo pariental, lobo occipital, cerebelo, ponte
Lobo occipital: Lobo pariental, lobo temporal, cerebelo
Cerebelo: Ponte, lobo occipital, lobo temporal
Ponte: lobo temporal, cerebelo, bulbo
Bulbo: Ponte e medula
Medula: Bulbo, gânglios

Gânglios: bexiga, medula, ponte e útero

Boca: Faringe e laringe
Tireoide: coração, laringe traqueia
Esôfago: laringe, diafragma e estômago

Diafragma: pulmão esôfago


Próstata: Reto, vesícula seminal, bexiga e ductos deferentes.
Ducto deferente: Próstata, epidídimo
Epidídimo: Ducto deferente e testículos
Pênis: uretra, veia, artéria e capilares

Bexiga: uretra, próstata, ureter, veia e artéria, ganglios
Uretra: bexiga, pênis.
Ureter: bexiga, rim
Rim: ureter, veia, artéria, capilares, supra renal
Supra renal: Rim, veia, artéria e capilares

Útero: Gânglios, trompa uterina, canal vaginal
Trompa uterina: útero, ovário
Canal Vaginal: útero
Ovário: trompa uterina, útero, veia, artéria e capilares

Coração: capilares, veia, artéria e tireoide.
*/


DROP TABLE IF EXISTS Card;
CREATE TABLE Card (
	id int NOT NULL AUTO_INCREMENT,
	sistema VARCHAR(100) CHARACTER SET 'utf8',
	pergunta VARCHAR(2000) CHARACTER SET 'utf8',
	resposta1 VARCHAR(1000) CHARACTER SET 'utf8',
	resposta2 VARCHAR(1000) CHARACTER SET 'utf8',
	resposta3 VARCHAR(1000) CHARACTER SET 'utf8',
	resposta4 VARCHAR(1000) CHARACTER SET 'utf8',
	resposta5 VARCHAR(1000) CHARACTER SET 'utf8',
	respostaCorreta VARCHAR(1000) CHARACTER SET 'utf8',
  PRIMARY KEY (id)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Para que serve a glote que fica na faringe?",
"A glote é uma cartilagem móvel que quando ocorre a deglutição fecha a abertura da laringe e força assim a passagem de alimentos para o esôfago.",
"É um órgão que fica no céu da boca, região denominado de palato, que auxilia no momento que é forçado o vomito.",
"A glote não tem interferência quando uma pessoa se engasga.",
"A glote é uma glândula que tem função de produzir enzimas digestivas, que ajuda na digestão de proteínas.",
"A glote é um órgão que apresenta uma função de absorção e digestão de lipídios e esta presente no palato.",
"A glote é uma cartilagem móvel que quando ocorre a deglutição fecha a abertura da laringe e força assim a passagem de alimentos para o esôfago.");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Qual órgão do sistema digestório é responsável pela absorção dos alimentos?",
"Estômago","Fígado","Intestino delgado","Intestino grosso","Pâncreas","Intestino delgado");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Qual órgão do sistema digestório é responsável pela desidratação dos restos alimentares tornando-os pastoso originando as fezes?",
"Estômago","Fígado","Intestino delgado","Intestino grosso","Pâncreas","Intestino grosso");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O que é a bile?",
"É uma enzima produzida pelo estomago com a função de digerir proteínas.",
"É o nome do suco produzido pelo fígado que apresenta uma coloração amarelo esverdeado e tem a função de transformar gotas grande de gorduras e pequenas.",
"É um suco digestivo produzido pelo Pâncreas com a função de digestão.",
"É uma enzima produzida nos rins que a função de filtrar o sangue.",
"É o nome cientifico da saliva e tem a função de iniciar a digestão dos lipídios na boca.",
"É o nome do suco produzido pelo fígado que apresenta uma coloração amarelo esverdeado e tem a função de transformar gotas grande de gorduras e pequenas.");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Qual dos órgãos abaixo realiza digestão mecânica?",
"Estômago","Esôfago","Intestino","Fígado","Dente","Dente");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A saliva e o Suco Pancreático contêm?",
"Açúcar que auxiliam a digestão.",
"Águas e gorduras que ajudam a quebrar os alimentos.",
"Apenas água.",
"Enzimas que ajudam a quebra os alimentos.",
"Proteínas utilizadas para estimular a produção do suco gástrico.",
"Enzimas que ajudam a quebra os alimentos.");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O Estômago é responsável:",
"Pela digestão mecânica e química dos alimentos.",
"Apenas pela digestão de gorduras.",
"Apenas pela digestão mecânica.",
"Pela absorção de água e sais minerais.",
"Apenas pela digestão e absorção de lipídios.",
"Pela digestão mecânica e química dos alimentos.");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A Bile é produzida:",
"Na vesícula biliar e armazenada no fígado.",
"No duodeno.",
"No fígado e lançado no estômago.",
"No estômago e armazenado na vesícula biliar.",
"No fígado e armazenado na vesícula biliar.",
"No fígado e armazenado na vesícula biliar.");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O bolo alimentar caminha pelo tubo digestivo graças a movimentos da parede desse tubo. Como é o nome desses movimentos?",
"Movimentos peristálticos",
"A força da gravidade.",
"Movimento voluntário.",
"Músculos abdominais.",
"Músculos mastigatórios.",
"Movimentos peristálticos");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A formação de um novo ser humano se inicia a partir de divisões mitóticas da célula zigoto (ou célula ovo) que se originou da fecundação de um óvulo por um espermatozóide. Durante essas divisões as células formadas passam por algumas etapas, entre essas a Mórula, Blástula, Gástrula e Nêurula. Durante uma dessas etapas há a formação de uma cavidade denominada Arquêntero ou gastrocela. Essa cavidade é o esboço do futuro tubo digestivo do individuo. Qual etapa seria essa?",
"Mórula","Blástula","Gástrula","Nêurula","","Gástrula");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Durante a formação do individuo as suas células passam por algumas etapas denominadas de Mórula, Blástula Gástrula e Nêurula. Durante a Gástrula surgem algumas regiões especificas: Blastóporo, Ectoderma, Gastrocela, e Mesentoderma. De cada uma dessas regiões as células irão se diferenciar e formar os órgãos dos nossos sistemas. O tubo digestivo se forma em qual dessas regiões?",
"Blastóporo","Ectoderma","Gastrocela","Mesentoderma","","Gastrocela");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O Blastóporo é uma região da Gástrula que pode originar duas estruturas diferentes do Sistema Digestivo, a depender do grupo de animais que o ser vivo pertence (deuterostômios ou protostômios). Quais são essas estruturas respectivamente?",
"Intestino grosso ou Intestino Delgado",
"Ânus ou Boca",
"Estômago ou fígado",
"Estomago ou Esôfago",
"Intestinos ou Boca",
"Ânus ou Boca");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Na fase embrionária formam-se os epitélios glandulares que dão origem às glândulas. Quais dessas glândulas faz parte do Sistema Digestório?",
"Sudoríparas",
"Mamária",
"Tireóide",
"Fígado",
"Salivares",
"Salivares");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A maioria dos animais possuem três folhetos germinativos: Ectoderma, Mesoderma e Endoderma. Em quais desses folhetos é formado as glândula salivares?",
"Ectoderma",
"Mesoderma",
"Endoderma",
"",
"",
"Endoderma");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Durante a formação dos seres humanos há a formação dos folhetos germinativos: Ectoderma, Mesoderma e Endoderma. Em quais desses são formados o pâncreas e o fígado?",
"Ectoderma",
"Mesoderma",
"Endoderma",
"",
"",
"Endoderma");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O estômago é um órgão do Sistema Digestório que tem a capacidade de digerir moléculas presente no bolo alimentar. Essa característica é auxiliada pela presença de um pH ácido nessa região. Apesar desse pH baixo, a parede do estomago não é danificada, pois ela possui um Epitélio de Revestimento. Esse Epitélio de Revestimento pertence a qual Tecido?",
"Epitelial",
"Conjuntivo",
"Cartilaginoso",
"Muscular",
"Nervoso",
"Epitelial");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Nos órgãos do sistema digestório há presença de tecidos musculares, que auxiliam no seu funcionamento. Existem três tipos de tecido muscular: o estriado esquelético, estriado cardíaco e o liso. Das opções abaixo qual combinação de órgão e tecido muscular esta correta?",
"Estômago e tecido estriado cardíaco",
"Fígado e tecido estriado",
"Intestino grosso e tecido estriado",
"Intestino delgado e tecido liso",
"Artéria e tecido estriado cardíaco",
"Intestino delgado e tecido liso");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O sistema digestório humano compõe-se de um longo tubo, com cerca de 9 m de comprimento, denominado de tubo digestório. Iniciando na boca e finalizando no ânus. No percorrer desse tubo há presença de algumas glândulas, quais são elas:",
"Glândula tireóide, glândulas salivares e fígado",
"Glândulas salivares, pâncreas e fígado",
"Glândula biliar, apêndice e fígado",
"Glândulas salivares, vesícula biliar e estômago",
"Apêndice, pâncreas e Glândulas salivares",
"Glândulas salivares, pâncreas e fígado");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O sistema digestório humano compõe-se de um longo tudo, denominado de tubo digestório. O inicio desse tubo é a boca onde se encontra os dentes, a língua e os canis provenientes das glândulas salivares. Qual é o nome da parte seguinte ao tubo digestório, após a boca?",
"Esôfago",
"Laringe",
"Faringe",
"Estômago",
"",
"Faringe");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O inicio do tubo digestório é mais estreito e se dilata na porção do Estômago. Em ordem, quais são os nomes das regiões do tubo digestório anterior ao estômago?",
"Língua, laringe e faringe",
"Boca, laringe e faringe",
"Boca, esôfago e laringe",
"Língua, esôfago e faringe",
"Boca, faringe e esôfago",
"Boca, faringe e esôfago");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","É função da saliva:",
"Digerir o amido",
"Desencadear o reflexo da sede",
"Umedecer a mucosa oral",
"Lubrificar os dentes",
"Todas as alternativas estão corretas",
"Todas as alternativas estão corretas");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A digestão de gorduras ocorre em qual parte do Intestino e pela ação de quais substâncias?",
"Cólon, lipase pancreática, bile",
"Estômago, lipase pancreática, bile",
"Duodeno, lipase gástrica, bile",
"Estômago, lipase gástrica, saliva",
"Duodeno, lipase pancreática, bile",
"Duodeno, lipase pancreática, bile");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O intestino delgado é um tubo com pouco mais de 6 m de comprimento por 4 cm de diâmetro, dividido em três regiões, quais os nomes dessas regiões?",
"Cárdia, pilórico e íleo",
"Apêndice, jejuno e ceco",
"Duodeno, jejuno e íleo",
"Jejuno, apêndice e duodeno",
"Duodeno, jejuno e apêndice",
"Duodeno, jejuno e íleo");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O intestino delgado é um tubo com pouco mais de 6 m de comprimento, dividido em três regiões, sendo a primeira denominada de Duodeno. Nessa região existe um canal colédono que traz as secreções produzidas por duas, das três glândulas do sistema digestórios. Quais são essas glândulas?",
"Salivar e fígado",
"Salivar e vesicular biliar",
"Salivar e pâncreas",
"Fígado e pâncreas",
"Vesícula biliar e fígado",
"Fígado e pâncreas");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O intestino grosso tem cerca de 50 cm de comprimento e entre 6 cm e 7 cm de diâmetro, sendo dividido em três partes. Quais são elas?",
"Cárdia, pilórico e reto",
"Apêndice, jejuno e íleo",
"Duodeno, jejuno e ceco",
"Ceco, apêndice e jejuno",
"Ceco, colo e reto",
"Ceco, colo e reto");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O intestino grosso é dividido em três partes, ceco, colo e reto. O ceco é uma bolsa de fundo cego, situada perto do intestino delgado. Ele não desempenha nenhuma função importante nos seres humanos, sendo considerado um órgão vestigial. Na extremidade fechada do ceco localiza-se uma estrutura na qual pode ocorrer o acúmulo de algumas estruturas alimentares que não são digeridas, causando um problema de saúde. Como é o nome dessa estrutura e desse problema de saúde?",
"Apêndice vermiforme e apendicite",
"Jejuno e apendicite",
"Íleo e pedras nos rins",
"Duodeno e apendicite",
"Apêndice vermiforme e pedras nos rins",
"Apêndice vermiforme e apendicite");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O pâncreas é uma glândula em formato triangular alongado, localizada sob o estômago, na alça do duodeno. Há dois tipos básicos de células secretoras no pâncreas: as exócrinas e endócrinas. Quais dessas glândulas secretam as substâncias de digestão e quais são essas substâncias.",
"Endócrinas e secretam os hormônios insulina e glucagon",
"Exócrinas e secretam bicarbonato e enzimas",
"Exócrinas e secretam os hormônios insulina e glucagon",
"Endócrinas e secretam bicarbonato e enzimas",
"",
"Exócrinas e secretam bicarbonato e enzimas");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O fígado é a maior glândula de nosso corpo e está localizado no lado direito do abdomem, na altura das últimas costelas, imediatamente abaixo do diafragma. Ele participa do metabolismo de digestão no organismo com a liberação de uma substância. Qual é o nome da substância?",
"Insulina",
"Glucagon",
"Bile",
"Bicarbonato",
"Saliva",
"Bile");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Para as substâncias presentes nos alimentos serem absorvidas por nossas células, a comida passa por dois tipos de digestão: a mecânica e química. Abaixo estão descritos alguns mecanismos da digestão e os respectivos locais onde ocorrem os processos. Qual combinação esta correta?",
"Digestão química que ocorre na boca com o auxilio dos dentes e língua",
"Digestão mecânica que ocorre no tubo digestivo pela ação de algumas enzimas",
"Digestão química presente no Esôfago por causa dos movimentos peristálticos",
"Digestão química no Intestino delgado auxiliada pelo suco pancreático",
"Digestão mecânica auxiliada pelas glândulas salivares no estômago",
"Digestão química no Intestino delgado auxiliada pelo suco pancreático");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","É função do esôfago:",
"a deglutição",
"a mastigação",
"a degustação",
"a digestão de carboidratos",
"a digestão de proteínas",
"a deglutição");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Após a digestão o alimento é então absorvido pelas células presentes na parede do tubo digestivo. A maioria dos alimentos é absorvida no intestino delgado e grosso. Porém alguns tipos de alimentos têm a capacidade de serem absorvidos no estômago. Quais dos alimentos abaixo são absorvidos no estômago?",
"Álcool etílico, água e certos sais",
"Proteína e Lipídios",
"Carboidratos e proteínas",
"Lipídios e água",
"Sais e proteínas",
"Álcool etílico, água e certos sais");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Para uma adequada digestão há necessidade da combinação entre enzima e pH. Quais das combinações abaixo esta INCORRETA conforme Enzima, pH ótimo e Substratos?",
"Amilase salivar, Neutro, Maltose e glicose",
"Pepsina, Básico, Lipídios",
"Lipase, Básico, Lipídios",
"Pepsina, Ácido, Proteínas",
"Lactase, Básico, Lactose",
"Pepsina, Ácido, Proteínas");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A superfície interna do intestino delgado possui milhões de pequenas dobras chamadas de vilosidades intestinais. As quais possuem dobrinhas microscópicas denominadas microvilosidades. Qual é a principal função dessas estruturas?",
"Produzir sucos digestivos",
"Diminuir o pH do intestino",
"Absorver nutrientes",
"Neutralizar o pH do estômago",
"Produção das fezes",
"Absorver nutrientes");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Os resíduos não aproveitados em uma alimentação levam cerca de 9 horas para chegar ao intestino grosso, onde permanecem alguns dias. Durante esse tempo ocorre absorção de água e sais e intensa proliferação de bactérias, as quais produzem substâncias úteis para o nosso organismo. Quais das substâncias abaixo não são produzidas por nossa flora intestinal?",
"Vitamina K",
"Vitamina B 12",
"Tiamina",
"Riboflavina",
"Bile",
"Bile");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Os carboidratos ao serem digeridos se transformam em glicídios passando então para o sangue que circula nos capilares sanguíneos. A união desses capilares forma a veia porta-hepática que transporta os nutrientes para uma glândula do nosso corpo, a qual absorve grande parte da glicose e a converte em glicogênio. Qual é o local do tubo digestivo que ocorre a absorção dos glicídios e o nome da glândula?",
"Estômago e pâncreas",
"Intestino grosso e pâncreas",
"Estômago e fígado",
"Intestino delgado e fígado",
"Intestino e apêndice",
"Intestino delgado e fígado");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Na região final do colo, há formação das fezes. Cerca de 30% da parte sólida das fezes compõe-se de bactérias vivas e mortas e os 70% restantes são constituídos por sais, muco, fibras de celulose e outros componentes não digeridos. Sendo assim, se uma pessoa elimina 10g de fezes, quantas gramas serão de bactérias?",
"3g",
"5g",
"7g",
"2g",
"8g",
"3g");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O processo da digestão é controlado pelo sistema nervoso autônomo e por hormônios. A visão, o cheiro e o sabor do alimento estimulam o sistema nervoso central a enviar estímulos às glândulas salivares e as glândulas estomacais, estimulando-as a produzir algumas substâncias. Quais são os nomes dessas substâncias?",
"Bile e suco pancreático",
"Saliva e suco gástrico",
"Saliva e bile",
"Secretina e suco gástrico",
"Saliva e secretina",
"Saliva e suco gástrico");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","O bolo alimentar após passar pelo estômago recebe o nome de quimo. A entrada do quimo no duodeno estimula células da parede intestinal a liberar no sangue o hormônio secretina. Qual seria a função desse hormônio?",
"Liberar a produção de saliva e do suco pancreático",
"Aumentar o pH do intestino para uma melhor digestão das proteínas",
"Estimula a liberação do suco pancreático e a produção de bile",
"Estimular a liberação de saliva e suco pancreático",
"Inibir a produção de suco gástrico e aumentar assim o pH do estômago",
"Estimula a liberação do suco pancreático e a produção de bile");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","A vesicular biliar para liberar a bile necessita receber um sinal do hormônio colecistoquinina ou pancreozimina. Assim que esse hormônio atinge a vesícula biliar, pela corrente sanguínea, ela se contrai e libera a bile. O que tem que estar presente no tubo digestivo para ocorrer a liberação da colecistoquinina?",
"A presença de um pH baixo no duodeno",
"A presença de secretina na corrente sanguínea",
"O pâncreas esta com o volume acima do normal",
"A presença de gorduras ou proteínas parcialmente digeridas no quimo",
"A presença do FSH no sangue",
"A presença de gorduras ou proteínas parcialmente digeridas no quimo");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("digestório","Quando se come um cozido, as batatas e a carne começam a ser digeridas respectivamente aonde?",
"No pâncreas e na boca",
"Na boca e no duodeno",
"No estômago e no duodeno",
"No intestino e no estômago",
"Na boca e no estômago",
"Na boca e no estômago");

-- Respiratório
insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O objetivo primordial do Sistema respiratório é possibilitar a respiração celular e pulmonar. Entre as reações descritas abaixo qual relaciona de forma correta os reagentes e os produtos da respiração celular?",
"Reagentes: O2 + H2O + C6H1206; Produtor: CO2 + energia + H20",
"Reagentes: CO2 + C6H1206; Produtor: energia + H20",
"Reagentes: O2 + H2O; Produtor: C6H1206 + energia",
"Reagentes: CO2 + energia; Produtor: H20 + C6H1206",
"Reagentes: energia + H20+ O2; Produtor: H20 + C6H1206",
"Reagentes: O2 + H2O + C6H1206; Produtor: CO2 + energia + H20");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O corpo humano realiza diversos metabolismos relacionados aos seus Sistemas, entre eles o respiratório, o urinário, o digestório, entre outros. Todas essas reações ocorrem de forma micro nas células em estruturas específicas denominadas de organelas. Das organelas descridas abaixo qual tem a função da respiração celular?",
"Ribossomos",
"Mitocôndrias",
"Lisossomos",
"Complexo de Golgi",
"Retículo endoplasmático liso",
"Mitocôndrias");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O termo respiração é empregado em dois níveis: celular e pulmonar. Entre as estruturas descritas abaixo qual tem a relação com esses níveis de respiração respectivamente?",
"Pulmão e ribossomos",
"Lisossomos e brônquio",
"Mitocôndrias e pulmão",
"Mitocôndrias e esôfago",
"Brônquio e Pulmão",
"Mitocôndrias e pulmão");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Dos órgãos descritos abaixo qual não faz parte do Sistema respiratório?",
"Boca",
"Laringe",
"Brônquio",
"Esôfago",
"Pulmão",
"Esôfago");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Qual das afirmações a seguir é verdadeira durante a inspiração?",
"A pressão intrapleural é positiva",
"A pressão intrapleural tem valor igual a zero",
"A pressão intrapleural é igual à pressão atmosférica",
"A pressão intrapleural é mais negativa do que durante a expiração",
"Nenhuma das respostas propostas",
"A pressão intrapleural é mais negativa do que durante a expiração");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A entrada da laringe é chamada de glote e apresenta uma estrutura cartilaginosa que funciona como uma válvula que evita que os alimentos entrem na laringe. Qual é o nome dessa cartilagem?",
"Epiglote",
"Faringe",
"Prega vocal",
"Septo nasal",
"Proeminência laríngea",
"Epiglote");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Existem duas opções de entrada de ar no nosso organismo, a boca e as cavidades nasais. Após a passagem por uma dessas vias o ar entre na faringe, que é um tubo que faz parte do Sistema Digestório e Respiratório. A faringe conduz alimentos e água para o esôfago e ar para a laringe. Na entrada da laringe existe uma cartilagem, denominada epiglote, que evita a entrada de água e alimentos pelo tubo errado. Qual é o nome da entrada da laringe?",
"Faringe",
"Glote",
"Prega vocal",
"Septo nasal",
"Proeminência laríngea",
"Glote");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A passagem de ar pela laringe pode produzir sons que possibilita a fala. Porém não é apenas a laringe que apresenta essa função e sim um conjunto de elementos. Quais são eles?",
"A boca, o esôfago e a laringe",
"A boca, a língua, e a faringe",
"A boca, a laringe, a língua e o nariz",
"A boca, o nariz, a faringe e laringe",
"A boca, a língua, o pulmão e o esôgafo",
"A boca, a laringe, a língua e o nariz");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A fala é a ação da combinação entre a laringe, a boca, a língua e o nariz. Das estruturas descritas abaixo qual delas estão presentes na laringe que auxilia no mecanismo da fala?",
"Epiglote",
"Glote",
"Língua",
"Pregas vocais",
"Septo nasal",
"Pregas vocais");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Ao passar a mão no pescoço à pessoa pode sentir a presença de anéis nessa região, os quais tem como função manter essa estrutura sempre aberta para a passagem de ar. Como é o nome dessa estrutura que faz parte do sistema respiratório?",
"Pregas vocais",
"Septo nasal",
"Epiglote",
"Glote",
"Traquéia",
"Traquéia");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A traquéia é um tubo de aproximadamente 1,5 cm de diâmetro por 10 cm de comprimento, com paredes reforçadas por anéis cartilaginosos. Qual é a função desses anéis?",
"Manter a traquéia sempre aberta para a passagem de ar",
"Evitar que alimentos entrem na traquéia",
"Auxiliar as vibrações das pregas vocais auxiliando na fala",
"Auxiliar no refluxo de alimentos que tenham entrado pelo canal errado",
"Permitir as trocas gasosas",
"Manter a traquéia sempre aberta para a passagem de ar");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Abaixo estão descritas algumas estruturas do Sistema respiratório e as suas respectivas funções. Qual dessas associações não esta correta conforme Estrutura e Função?",
"Epiglote: Controla a passagem de ar para a traquéia impedindo a passagem de alimento",
"Septo nasal: Impede a passagem de alimentos do esôfago para a laringe",
"Anéis da traquéia: Permite a abertura da traquéia para a passagem de ar",
"Pregas vocais: Auxilia na fala",
"",
"Septo nasal: Impede a passagem de alimentos do esôfago para a laringe");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A traquéia divide-se em dois tubos curtos com anéis cartilaginosos, semelhantes aos da traquéia, que penetram nos pulmões. Qual é o nome desse tubo?",
"Faringe",
"Laringe",
"Brônquios",
"Bronquíolos",
"Alvéolos",
"Brônquios");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Em algumas regiões do Sistema respiratório há presença de um epitélio ciliado, rico em células produtoras de muco. Partículas de poeiras e bactérias em suspensão no ar inalado aderem a esse muco sendo “varridas” em direção à garganta pelo batimento dos cílios. Qual das estruturas abaixo não possui esse epitélio.",
"Traquéia",
"Brônquios",
"Alvéolos",
"Bronquíolos",
"",
"Alvéolos");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Na traquéia, brônquios e bronquíolos há a produção de muco e a presença de um epitélio ciliado. Qual é a função desse epitélio?",
"Manter a traquéia sempre aberta para a passagem de ar",
"Evitar que alimentos entrem na traquéia",
"Auxiliar as vibrações das pregas vocais auxiliando na fala",
"Eliminar partículas de poeiras e bactérias que tenham entrado na traquéia",
"Auxiliar no refluxo de alimentos que tenham entrado pelo canal errado",
"Eliminar partículas de poeiras e bactérias que tenham entrado na traquéia");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Existem alguns problemas de saúde que ocorrer o acúmulo de água no espaço pleural. Em qual região do corpo humano encontramos as pleuras parietal e visceral?",
"Laringe",
"Faringe",
"Esôfago",
"Traquéia",
"Pulmões",
"Pulmões");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Existe uma região do sistema respiratório, a qual está em contato com o sistema circulatório, possibilitando que ocorra o processo de trocas gasosas. Qual é o nome dessa região?",
"Alvéolos pulmonares",
"Laringe",
"Faringe",
"Brônquios",
"Bronquíolos",
"Alvéolos pulmonares");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Nos alvéolos pulmonares ocorre a junção de dois tipos de sistemas: respiratório e circulatório. É nessa região que ocorrem as trocas gasosas. O gás carbônico presente em concentração relativamente alta no sangue difunde-se para os alvéolos e o gás oxigênio faz o caminho inverso. Qual é o nome desse processo de trocas gasosas?",
"Osmose",
"Hematose",
"Bomba de sangue",
"Inspiração",
"Expiração",
"Hematose");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","As células eucarióticas animais são envolvidas por uma membrana denominada plasmática que apresenta a função transportar substâncias entre os meio intra e extracelular e permite uma diferença de concentrações moleculares entre esses meios. Dos transportes descritos abaixo qual esta relacionado a trocas de gases na hematose?",
"Osmose",
"Bomba de sódio e potássio",
"Difusão simples",
"Transporte ativo",
"Difusão facilitada",
"Difusão simples");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Entre os tipos de transporte que ocorrem na membrana plasmática encontramos a difusão simples, a qual ocorre no processo da Hematose. O que permite o funcionamento desse tipo de transporte e o que é transportado na hematose:",
"Há transporte de água pela diferença de concentração",
"Há transporte de gases contra o gradiente de concentração",
"Há transporte de nutrientes do local mais concentrado para o menos concentrado",
"Há transporte de gases a favor do gradiente de concentração",
"Há transporte de sódio e potássio contra o gradiente de concentração",
"Há transporte de gases a favor do gradiente de concentração");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A ventilação pulmonar permite o bom funcionamento energético do organismo. Entre os mecanismos citados abaixo, qual NÃO faz parte da ventilação pulmonar?",
"A renovação do ar dos pulmões",
"A troca de gases",
"A eliminação do excesso de gás carbônico",
"Garante o suprimento contínuo de gás oxigênio",
"A eliminação, em alta concentração, do gás oxigênio",
"A eliminação, em alta concentração, do gás oxigênio");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Dos processos citados abaixo, qual NÃO faz parte da fisiologia do Sistema respiratório?",
"A inspiração com a eliminação do gás carbônico em alta concentração pelas cavidades nasais",
"O relaxamento do diafragma permitindo a expiração",
"A contração da musculatura do diafragma permitindo a inspiração",
"A hematose com a troca de gases a favor do gradiente de concentração",
"",
"A inspiração com a eliminação do gás carbônico em alta concentração pelas cavidades nasais");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Qual das afirmações a seguir é verdadeira durante a inspiração?",
"A pressão intrapleural é positiva",
"A pressão intrapleural tem valor igual a zero",
"A pressão intrapleural é igual à pressão atmosférica",
"A pressão intrapleural é mais negativa do que durante a expiração",
"Nenhuma das respostas propostas",
"A pressão intrapleural é mais negativa do que durante a expiração");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Considere as seguintes etapas do processo respiratório no homem:
I. Durante a inspiração, o diafragma se contrai e desce aumentando o volume da caixa torácica.
II. Quando a pressão interna na caixa torácica diminui e se torna menor que a pressão do ar atmosférico, o ar penetra nos pulmões.
III. Durante a expiração, o volume torácico aumenta, e a pressão interna se torna menor que a pressão do ar atmosférico.
IV. Quando o diafragma relaxa, ele reduz o volume torácico e empurra o ar usado para fora dos pulmões. Assinale as opções corretas:",
"I e II",
"II, III e IV",
"I, II e III",
"I, II e IV",
"",
"I, II e IV");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Dos mecanismos citados abaixo qual explica melhor o funcionamento da inspiração?",
"A contração dos músculos intercostal com o relaxamento do diafragma aumenta o volume do tórax",
"O relaxamento do diafragma com a contração dos músculos intercostal",
"O relaxamento dos músculos intercostal e diafragma diminuindo o volume torácico",
"O diafragma se contrai e desce aumentando o volume da caixa torácica",
"A contração da musculatura cardíaca aumentando a volume torácico",
"O diafragma se contrai e desce aumentando o volume da caixa torácica");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O aumento do volume do tórax, durante o processo de respiração, por causa da contração muscular, favorece que mecanismo e por qual motivo isso ocorre?",
"Permiti a saída de gases por causa de diferença de concentração",
"Possibilita a saída de gases por causa da pressão torácica",
"Há eliminação de gases por causa do acumulo de gás carbônico durante a respiração celular",
"Permite a entrada, apenas do Gás oxigênio, por causa de diferença de concentração",
"Permite a entrada de gases por causa da diferença de pressão intra e extratorácica",
"Permite a entrada de gases por causa da diferença de pressão intra e extratorácica");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Existe a possibilidade de aumentarmos ou diminuirmos, de maneira voluntária, a nossa freqüência respiratória. Entretanto, esse processo é primordialmente de controle involuntário, sendo controlado por qual sistema?",
"Sistema nervoso",
"Sistema endócrino",
"Sistema osmótico",
"Sistema digestivo",
"Sistema circulatório",
"Sistema nervoso");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O sistema nervoso controla nossa freqüência cardíaca independente de nossa vontade. Esse controle é realizado em qual região do sistema nervoso?",
"Neurohipófise",
"Tronco encefálico",
"Adenohipófise",
"Cerebelo",
"Tálamo",
"Tronco encefálico");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O processo físico que rege as trocas gasosas entre o alvéolo capilar e o vaso sanguíneo é:",
"Transporte ativo primário",
"Osmose",
"Difusão simples",
"Transporte ativo secundário",
"Difusão facilitada",
"Difusão facilitada");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Se houver diminuição da concentração de gás oxigênio no sangue, o sistema nervoso entra em ação para alterar a freqüência respiratória. Como isso ocorre?",
"Liberação de prolactina que estimula a contração dos músculos respiratórios",
"Liberação de gás carbônico no sangue e com isso o aumento da hematose",
"Produção de mensageiro químico diminuindo a frequência respiratória",
"Detecção por receptores químicos nas artérias fazendo o sistema nervoso aumentar a frequência respiratória",
"",
"Detecção por receptores químicos nas artérias fazendo o sistema nervoso aumentar a frequência respiratória");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Após a hematose o gás oxigênio é transportado para as células, para que ocorra a respiração celular, por que tipo de células sanguíneas?",
"Plaquetas",
"Linfócitos",
"Plasma",
"Leucócitos",
"Hemácias",
"Hemácias");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Cada hemácias pode transportar 1 bilhão de moléculas de gás oxigênio. Sabendo que cada hemácias possuem 250 milhões de moléculas de hemoglobina, quantas moléculas de gás oxigênio cada hemoglobina pode transportar?",
"4",
"8",
"6",
"2",
"10",
"4");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O gás oxigênio é transportado pelas hemácias pela proteína hemoglobina, formando o complexo oxiemoglobina. Já o gás carbônico pode ser transportado em três conformações diferentes. Quais das descritas abaixo está INCORRETA?",
"Dissolvido no plasma pela forma de íons HCO 3 -",
"Íon H + dissolvido no Plasma",
"Carboemoglobina na hemoglobina",
"CO2 no plasma",
"",
"Íon H + dissolvido no Plasma");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Qual é o nome do tubo oco constituído por cartilagem, em que se localizam as pregas vocais?",
"Faringe",
"Glote",
"Laringe",
"Traquéia",
"Bronquíolos",
"Laringe");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Se aspirarmos com força um canudinho de refresco de paredes moles, estas encostam uma na outra e o canudinho fecha-se. O que evita situação semelhante em certas vias respiratórias é a presença de?",
"Células achatadas",
"Cílios",
"Muco",
"Reforço de cartilagem",
"Músculo",
"Reforço de cartilagem");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","O transporte de CO2 pelo sangue, dos tecidos aos alvéolos ocorre:",
"Totalmente pelo plasma sanguíneo, na forma de ácido carbônico",
"Predominantemente no interior das plaquetas sanguíneas",
"Totalmente no interior das hemácias, na forma de oxiemoglobina",
"50% pelo plasma e 50% no interior das hemácias, na forma de oxiemoglobina",
"70% pelos plasma na forma de HCO3-, 23% pela hemácias na forma de carboemoglobina e 7% na forma de CO2 pelo plasma",
"70% pelos plasma na forma de HCO3-, 23% pela hemácias na forma de carboemoglobina e 7% na forma de CO2 pelo plasma");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A sequência das estruturas do sistema respiratório pulmonar é:",
"Fossas nasais - faringe - laringe - traquéia - brônquios",
"Fossas nasais - laringe - esôfago - brônquios - traquéia",
"Fossas nasais - laringe - faringe - traquéia - brônquios",
"Fossas nasais - faringe - esôfago - traquéia - brônquios",
"Fossas nasais - faringe - traquéia - laringe – brônquios",
"Fossas nasais - faringe - laringe - traquéia - brônquios");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Os pulmões possuem algumas diferenças anatômicas. Comparando-se o pulmão direito com o pulmão esquerdo, observamos a existência de um número diferente de lobos pulmonares. Esta diferença está indicada na seguinte alternativa:",
"No lado esquerdo, o pulmão possui três lobos",
"O pulmão esquerdo possui um lobo superior e um lobo inferior",
"O pulmão direito possui apenas dois lobos",
"O pulmão direito possui dois lobos laterais e um lobo medial",
"O pulmão esquerdo é duas vezes maior do que o pulmão direito",
"O pulmão esquerdo possui um lobo superior e um lobo inferior");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","A respiração pulmonar funciona por dois mecanismos: a inspiração e a expiração. Na expiração NÃO ocorre:",
"Relaxamento do diafragma",
"Diminuição do volume pulmonar",
"Contração da musculatura diafragmática",
"Aumento da pressão intratorácica em relação à pressão atmosférica",
"Eliminação de dióxido de carbono",
"Contração da musculatura diafragmática");

insert into Card (sistema, pergunta, resposta1, resposta2, resposta3, resposta4, resposta5, respostaCorreta)
values ("respiratório","Qual das cartilagens da laringe produz a proeminência anterior da laringe conhecida pelo nome de 'pomo de Adão'?",
"Epiglote",
"Tireóide",
"Cricóide",
"Laríngea",
"Septo",
"Laríngea");


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



DROP TABLE IF EXISTS Pesquisa;
CREATE TABLE Pesquisa (
	id int NOT NULL AUTO_INCREMENT,
	jidServer VARCHAR(80) CHARACTER SET 'utf8',
	jidClient VARCHAR(80) CHARACTER SET 'utf8',
	conhecimento VARCHAR(1) CHARACTER SET 'utf8',
	utilidade VARCHAR(1) CHARACTER SET 'utf8',
	dificuldade VARCHAR(1) CHARACTER SET 'utf8',
	satisfacao VARCHAR(1) CHARACTER SET 'utf8',
	dataHora datetime,
  PRIMARY KEY (id)
)ENGINE=InnoDb DEFAULT CHARSET=utf8;


delimiter //

-- startGameStatus
drop PROCEDURE if exists startGameStatus //
CREATE PROCEDURE startGameStatus(IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8', IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8')
BEGIN
	DECLARE v_limiteTempo INT default 10;
	DECLARE v_startUp dateTime;
	DECLARE v_secs INT DEFAULT 0;
	
	set v_startUp := now();
	set v_secs := 0;
	
	select TIMESTAMPDIFF(SECOND,v_startUp, DATE_ADD(v_startUp, INTERVAL v_limiteTempo MINUTE)) into v_secs;
	
	replace into GameStatus (jidServer, jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
							menuText, option1, option2, option3, option4, option5, 
							score, highScorePosition, highScoreText, gameEndMessage) 
	values (p_jidServer, p_jidClient, "timer", 
			concat("Vc tem ",(v_secs div 60),":",(v_secs % 60)," minutos para conquistar ",
					(select count(*) from Orgao)," órgãos do Body!! Boa sorte!!"), 
			"", "", "", "", "", "", "", "", "", "", 0, 0, "", "");	
		
	replace into GamePlay(jidServer, jidClient, startUp, attempts, idLastCard)
	values (p_jidServer, p_jidClient, v_startUp, 0, null);
		
	delete from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient;
END //


-- updateGameStatus
drop PROCEDURE if exists updateGameStatus //
CREATE PROCEDURE updateGameStatus(IN p_option VARCHAR(1000) CHARACTER SET 'utf8', 
				IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
				IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8')
BEGIN
	DECLARE v_limiteTempo INT default 10;
	DECLARE v_startUp dateTime;
	DECLARE v_attempts INT DEFAULT 0;		
	DECLARE v_secs INT DEFAULT 0;		
	DECLARE v_score INT DEFAULT 0;	
	DECLARE v_opcao INT DEFAULT 0;	
	
	DECLARE v_statusId VARCHAR(80) CHARACTER SET 'utf8';
	DECLARE v_idCard INT DEFAULT 0;			
	
	DECLARE v_totalOrgaos INT DEFAULT 0;
	DECLARE v_totalOrgaosConquistados INT DEFAULT 0;	
	DECLARE v_sistema VARCHAR(100) CHARACTER SET 'utf8';
	DECLARE v_respostaCorreta VARCHAR(1000) CHARACTER SET 'utf8';
	DECLARE v_idOrgaoPerdido INT DEFAULT 0;	
	DECLARE v_idOrgaoConquistado INT DEFAULT 0;		
	
	DECLARE v_gameEndMessage VARCHAR(1000) CHARACTER SET 'utf8';
    DECLARE v_highScorePosition INT DEFAULT 0;
    DECLARE v_highScoreText VARCHAR(1000) CHARACTER SET 'utf8';
	
	select startUp, attempts, idLastCard
	into v_startUp, v_attempts, v_idCard
	from GamePlay
	where jidServer = p_jidServer and jidClient = p_jidClient;	
	
	set v_secs := TIMESTAMPDIFF(SECOND, v_startUp, now());
	
	select count(*) into v_totalOrgaos from Orgao;
		
	select count(*) into v_totalOrgaosConquistados 
	from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient;
	
	if (v_secs < 60 * v_limiteTempo) then					
		select statusId	into v_statusId
		from GameStatus
		where jidServer = p_jidServer and jidClient = p_jidClient;	
		
		if (v_statusId = "timer") then
			set v_attempts := v_attempts + 1;	
		
			-- preparar menu de carta; statusId = card
			SELECT id into v_idCard 
			FROM Card where sistema in (
				select distinct sistema from Orgao 
				where id not in (
					select idOrgao from OrgaosConquistados 
					where jidServer = p_jidServer and jidClient = p_jidClient)) ORDER BY RAND() LIMIT 1;
						
			select round(3*rand()) into v_opcao;
			
			if (v_opcao = 0) then
				replace into GameStatus (jidServer, jidClient, statusId, message, 
								imagePath, httpText, httpImage, promptText, menuText, 
								option1, option2, option3, option4, option5, 
								score, highScorePosition, highScoreText, gameEndMessage) 
				values (p_jidServer, p_jidClient, "card", "", 
						"", "", "", "", 
						concat(v_attempts,"ª pergunta: ",(select pergunta from Card where id = v_idCard)), 
						(select resposta1 from Card where id = v_idCard), 
						(select resposta2 from Card where id = v_idCard), 
						(select resposta3 from Card where id = v_idCard), 
						(select resposta4 from Card where id = v_idCard), 
						(select resposta5 from Card where id = v_idCard), 
						0, 0, "", "");	
			end if;
			
			if (v_opcao = 1) then
				replace into GameStatus (jidServer, jidClient, statusId, message, 
								imagePath, httpText, httpImage, promptText, menuText, 
								option1, option2, option3, option4, option5, 
								score, highScorePosition, highScoreText, gameEndMessage) 
				values (p_jidServer, p_jidClient, "card", "", 
						"", "", "", "", 
						concat(v_attempts,"ª pergunta: ",(select pergunta from Card where id = v_idCard)), 
						(select resposta2 from Card where id = v_idCard), 
						(select resposta1 from Card where id = v_idCard), 
						(select resposta4 from Card where id = v_idCard), 
						(select resposta3 from Card where id = v_idCard), 
						(select resposta5 from Card where id = v_idCard), 
						0, 0, "", "");	
			end if;
			
			if (v_opcao = 2) then
				replace into GameStatus (jidServer, jidClient, statusId, message, 
								imagePath, httpText, httpImage, promptText, menuText, 
								option1, option2, option3, option4, option5, 
								score, highScorePosition, highScoreText, gameEndMessage) 
				values (p_jidServer, p_jidClient, "card", "", 
						"", "", "", "", 
						concat(v_attempts,"ª pergunta: ",(select pergunta from Card where id = v_idCard)), 
						(select resposta3 from Card where id = v_idCard), 	
						(select resposta5 from Card where id = v_idCard), 
						(select resposta2 from Card where id = v_idCard), 
						(select resposta1 from Card where id = v_idCard), 
						(select resposta4 from Card where id = v_idCard), 											
						0, 0, "", "");	
			end if;
			
			if (v_opcao = 3) then
				replace into GameStatus (jidServer, jidClient, statusId, message, 
								imagePath, httpText, httpImage, promptText, menuText, 
								option1, option2, option3, option4, option5, 
								score, highScorePosition, highScoreText, gameEndMessage) 
				values (p_jidServer, p_jidClient, "card", "", 
						"", "", "", "", 
						concat(v_attempts,"ª pergunta: ",(select pergunta from Card where id = v_idCard)), 
						(select resposta4 from Card where id = v_idCard), 
						(select resposta1 from Card where id = v_idCard), 
						(select resposta2 from Card where id = v_idCard), 
						(select resposta5 from Card where id = v_idCard), 
						(select resposta3 from Card where id = v_idCard), 						
						0, 0, "", "");	
			end if;
					
			replace into GamePlay(jidServer, jidClient, startUp, attempts, idLastCard)
			values (p_jidServer, p_jidClient, v_startUp, v_attempts, v_idCard);
			
		else if (v_statusId = "card") then
			SELECT sistema, respostaCorreta into v_sistema, v_respostaCorreta 
			FROM Card where id = v_idCard ;
					
			if (p_option = v_respostaCorreta) then
				-- se acertou então ...
				select id into v_idOrgaoConquistado from Orgao 
				where sistema = v_sistema and id not in (select idOrgao from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient) 
				ORDER BY RAND() LIMIT 1;
								
				insert into OrgaosConquistados (jidServer, jidClient, idOrgao) 
				values (p_jidServer, p_jidClient, v_idOrgaoConquistado);
				
				select count(*) into v_totalOrgaosConquistados 
				from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient;	
				
				if (v_totalOrgaosConquistados = v_totalOrgaos) then
					-- conquistou todos os orgaos então gravar mensagem de fim de partida
					set v_gameEndMessage := concat("Parabéns!! Vc conquistou o Body em ",
												(v_secs div 60),":",
												(case when length(v_secs % 60) = 1 then concat("0",(v_secs % 60)) else (v_secs % 60) end),
												" minutos e ",v_attempts," tentativas!");

					set v_score := (60*v_limiteTempo - v_secs);
					
					insert into Results (jidServer,	jidClient,	score, dateTime)
					values (p_jidServer, p_jidClient, v_score, now());

					set v_highScorePosition := (select count(*)+1 from Results where score <= v_score and name is not null);
					set v_highScoreText := "Informe um NOME para ser adicionado na lista de Melhores Resultados:";
					
					replace into GameStatus (jidServer,	jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
											menuText, option1, option2, option3, option4, option5, score, 
											highScorePosition, highScoreText, gameEndMessage) 
					values (p_jidServer, p_jidClient, "end", "", "", "", "", "", 
							"", "", "", "", "", "", v_score, v_highScorePosition, v_highScoreText, v_gameEndMessage);
				else
					-- parabenizar e exibir orgao conquistado; statusId = feedback					
					replace into GameStatus (jidServer,	jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
									menuText, option1, option2, option3, option4, option5, 
									score, highScorePosition, highScoreText, gameEndMessage) 
					values (p_jidServer, p_jidClient, "feedback", 
						concat("Parabéns, vc acertou!! Como prêmio vc conquistou o órgão:", (select nome from Orgao where id = v_idOrgaoConquistado),"."), 
							"", "", "", "", "", "", "", "", "", "", 0, 0, "", "");	
				end if;
			else
				-- se errou então informar erro e exibir orgao perdido; statusId = feedback				
				if (v_totalOrgaosConquistados > 0) then
					select id into v_idOrgaoPerdido from Orgao 
					where id in (select idOrgao from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient) 
					ORDER BY RAND() LIMIT 1;
										
					delete from OrgaosConquistados where jidServer = p_jidServer and jidClient = p_jidClient and idOrgao = v_idOrgaoPerdido;
					replace into GameStatus (jidServer, jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
									menuText, option1, option2, option3, option4, option5, 
									score, highScorePosition, highScoreText, gameEndMessage) 
					values (p_jidServer, p_jidClient, "feedback", 
						concat("Que pena, vc errou!! A resposta correta é: ",v_respostaCorreta,
								". Como punição vc perdeu o órgão:", (select nome from Orgao where id = v_idOrgaoPerdido),"."), 
							"", "", "", "", "", "", "", "", "", "", 0, 0, "", "");	
				else
					replace into GameStatus (jidServer, jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
									menuText, option1, option2, option3, option4, option5, 
									score, highScorePosition, highScoreText, gameEndMessage) 
					values (p_jidServer, p_jidClient, "feedback", concat("Que pena, vc errou!! A resposta correta é: ",v_respostaCorreta,"."), 
							"", "", "", "", "", "", "", "", "", "", 0, 0, "", "");	
				end if;
			end if;
			
		else if (v_statusId = "feedback") then
			-- exibir timer; statusId = timer			
			set v_secs := 60*v_limiteTempo - v_secs;
			replace into GameStatus (jidServer, jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
							menuText, option1, option2, option3, option4, option5, 
							score, highScorePosition, highScoreText, gameEndMessage) 
			values (p_jidServer, p_jidClient, "timer", 
					concat("Restam ",(v_secs div 60),":",
							(case when length(v_secs % 60) = 1 then concat("0",(v_secs % 60)) else (v_secs % 60) end)," minutos e ",
							(v_totalOrgaos - v_totalOrgaosConquistados)," órgão(s) para conquistar o Body!!"), 
					"", "", "", "", "", "", "", "", "", "", 0, 0, "", "");								
		end if;
		end if;			
		end if;	
	else
		-- tempo acabou então gravar mensagem de fim de partida
		set v_gameEndMessage := concat("Que pena, o tempo acabou!! Vc conquistou apenas ",v_totalOrgaosConquistados," órgão(s) do Body!!");

		set v_highScorePosition := 0;
		set v_highScoreText := "";
		
		replace into GameStatus (jidServer, jidClient, statusId, message, imagePath, httpText, httpImage, promptText, 
								menuText, option1, option2, option3, option4, option5, score, 
								highScorePosition, highScoreText, gameEndMessage) 
		values (p_jidServer, p_jidClient, "end", "", "", "", "", "", 
				"", "", "", "", "", "", 0, 
				v_highScorePosition, v_highScoreText, v_gameEndMessage);				
	end if;
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
		SELECT concat('### Melhores Resultados ###\n', v_result);
	else
		SELECT '### Melhores Resultados ###\n';
	end if;
END //


drop PROCEDURE if exists registrarPesquisa //
CREATE PROCEDURE registrarPesquisa(IN p_jidServer VARCHAR(80) CHARACTER SET 'utf8',
					IN p_jidClient VARCHAR(80) CHARACTER SET 'utf8',
					IN p_conhecimento VARCHAR(5000) CHARACTER SET 'utf8',
					IN p_utilidade VARCHAR(5000) CHARACTER SET 'utf8',
					IN p_dificuldade VARCHAR(5000) CHARACTER SET 'utf8',
					IN p_satisfacao VARCHAR(5000) CHARACTER SET 'utf8')
BEGIN
	insert into Pesquisa (jidServer, jidClient, conhecimento, utilidade, dificuldade, satisfacao, dataHora)
	values (p_jidServer, p_jidClient, SUBSTR(p_conhecimento,1,1), SUBSTR(p_utilidade,1,1), 
			SUBSTR(p_dificuldade,1,1), SUBSTR(p_satisfacao,1,1), now());	
	
END // 

delimiter ;
