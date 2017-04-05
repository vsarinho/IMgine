import os, pprint, sys, time, threading, mysql.connector
import urllib2, json, subprocess
import requests
from requests_toolbelt import MultipartEncoder


class MyThread(threading.Thread):
    def __init__(self):
        super(MyThread, self).__init__()

        self.exit = False
        self.counter = 0

    def finish(self):
        self.exit = True

    def run(self):
         while (not self.exit):
             self.monitoring()
             time.sleep(0.5)

    def monitoring(self):
        if self.counter > 40:
            print("Server-"+sys.argv[1]+" => "+time.ctime())
            self.counter = 0;

        self.counter = self.counter + 1

        #verificar mensagens do BD para enviar
        cnx = mysql.connector.connect(user='root', password='root', database='zapserver', use_unicode=True)
        # cnx = pymysql.connect(host='localhost', user='root', password='root', db='zapserver', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)

        cursor = cnx.cursor()
        cursor.execute('SET NAMES utf8mb4')
        cursor.execute("SET CHARACTER SET utf8mb4")
        cursor.execute("SET character_set_connection=utf8mb4")

        cursor.execute("select id, jidServer, jidClient, message, data, length(data), url, extension, imageLabel "
                    "from Queue where (dateTimetoSend < now() or dateTimetoSend is null) and status = 'S' "
                    "and jidServer = '"+jidServer+"' and url = 'facebook' LIMIT 10")

        currentIDs = []

        for (row0, row1, row2, row3, row4, row5, row6, row7, row8) in cursor:
            req = urllib2.Request(URL_ACCESS_TOKEN)
            req.add_header('Content-Type', 'application/json')

            if row8 is None:
                print("Text Message "+str(row0))
                try:
                    postdata = {"recipient":{"id":str(row2) },
	                            "message":{"text":row3.encode('utf-8', 'ignore').decode('utf-8') }}
                    data = json.dumps(postdata)
                    urllib2.urlopen(req, data)
                except:
                    e = sys.exc_info()[0]
                    print("Error: %s" % e)

                currentIDs += [str(row0)]

        for id in currentIDs:
            cursor.execute("DELETE FROM Queue where id = %s",[id])
            print("Removing "+id)

        cnx.commit()
        cursor.close()


# Getting the token from command-line is better than embedding it in code,
# because tokens are supposed to be kept secret.
GET_LOCAL_FILE_URL = "http://localhost:8080/ZapServerUtil/getLocalFile&sKey=w_er_kfj54kdsaqz_y34...+q-+&path="
URL_ACCESS_TOKEN = 'https://graph.facebook.com/v2.6/me/messages?access_token=' + str(sys.argv[3])
ACCESS_TOKEN = str(sys.argv[3])
jidServer = sys.argv[2]
print ('Starting jidServer:'+jidServer)

thread = MyThread()
thread.start()

# Keep the program running.
while 1:
    time.sleep(10)
