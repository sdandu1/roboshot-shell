script_location=(pwd)

cp ${script_location}/Files/mongodb.conf /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod

#/etc/yum.repos.d/mongo.repo
#

