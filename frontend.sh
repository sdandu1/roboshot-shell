script_location=$(pwd)
LOG= /tmp/roboshop
status_check()
{
   if [ $? -eq 0 ]; then
     echo success
   else
     echo -e "\e[31mFailure\e[0m"
     echo "Refer log file for mode details", LOG = ${LOG}
     exit
   fi
 }

echo -e '\e[35m Install Nginx\e[0m'
yum install nginx -y &>>${LOG}
status_check

systemctl enable nginx
systemctl start nginx
echo -e '\e[35m Remove Nginx old content\e[0m'
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

echo -e '\e[35m Download Frontend content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo $?

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${LOG}
status_check

echo -e '\e[35m Copy the Roboshot Contect\e[0m'
cp ${script_location}/Files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx &>>${LOG}
status_check

#Trouble shooting commnds
#sudo netstat -lntp
