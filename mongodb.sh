#source common.sh

#print_head "Copy MongoDB Repo file"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

#print_head "Install MongoDB"
yum install mongodb-org -y  &>>${LOG}
status_check

#/etc/yum.repos.d/mongo.repo
#
#

