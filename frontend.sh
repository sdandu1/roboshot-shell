script_location=$(pwd)
LOG=/tmp.roboshop.log

echo -e '\e[35m Install Nginx\e[0m'
yum install nginx -y &>>${LOG}
if [ $? -eq 0 ]; then
  echo success
else
  echo failure
fi

systemctl enable nginx
systemctl start nginx
echo -e '\e[35m Remove Nginx old content\e[0m'
rm -rf /usr/share/nginx/html/* &>>${LOG}
if [ $? -eq 0 ]; then
  echo success
else
  echo failure
fi

echo -e '\e[35m Download Frontend content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo $?

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${LOG}
if [ $? -eq 0 ]; then
  echo success
else
  echo failure

fi

echo -e '\e[35m Copy the Roboshot Contect\e[0m'
cp ${script_location}/Files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx &>>${LOG}
if [ $? -eq 0 ]; then
  echo success
else
  echo failure

fi

#Trouble shooting commnds
#sudo netstat -lntp
