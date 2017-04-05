#!/bin/sh

botName=$1
jidServer=$2
access_token=$3

DB_USER="root"
export MYSQL_PWD="root"
DB_NAME="zapserver"

while true; do
  results=$(mysql --user $DB_USER $DB_NAME -Bse "select id, jidClient, extension, imageLabel, id from Queue where (dateTimetoSend < now() or dateTimetoSend is null) and status = 'S' and imageLabel is not null and jidServer = '$jidServer' and url = 'facebook' LIMIT 1;")

  for rows in "$results[@]"
  do
    id=`echo ${rows}| awk '{print $1}'`;
    jidClient=`echo ${rows}| awk '{print $2}'`;
    extension=`echo ${rows}| awk '{print $3}'`;
    imageLabel=`echo ${rows}| awk '{print $4}'`;

    if [ "$extension" = "mp4" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"video", "payload":{}}}' -F 'filedata=@'$imageLabel';type=video/mp4' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

    if [ "$extension" = "avi" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"video", "payload":{}}}' -F 'filedata=@'$imageLabel';type=video/avi' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi


    if [ "$extension" = "mp3" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"audio", "payload":{}}}' -F 'filedata=@'$imageLabel';type=audio/mp3' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

    if [ "$extension" = "ogg" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"audio", "payload":{}}}' -F 'filedata=@'$imageLabel';type=audio/ogg' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

    if [ "$extension" = "png" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"image", "payload":{}}}' -F 'filedata=@'$imageLabel';type=image/png' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

    if [ "$extension" = "jpg" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"image", "payload":{}}}' -F 'filedata=@'$imageLabel';type=image/jpg' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi
    
    if [ "$extension" = "gif" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"image", "payload":{}}}' -F 'filedata=@'$imageLabel';type=image/gif' "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

    if [ "$extension" = "pdf" ]
    then    
      echo ${id} ${jidClient} ${extension} ${imageLabel} ;

      curl  -F 'recipient={"id":"'$jidClient'"}' -F 'message={"attachment":{"type":"file", "payload":{}}}' -F 'filedata=@'$imageLabel "https://graph.facebook.com/v2.6/me/messages?access_token=$access_token"

      $(mysql --user $DB_USER $DB_NAME -e "delete from Queue where id = $id;")
    fi

  done
  sleep 1
done &
