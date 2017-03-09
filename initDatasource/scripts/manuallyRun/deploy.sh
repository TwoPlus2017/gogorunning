#!/bin/bash
project_path=/wsworkenv/projects

# deploy superwebsitebuilder
echo "start to deploy superwebsitebuilder"
project_name=superwebsitebuilder
# get latest source code from git
git_url=https://github.com/TwoPlus2017/superwebsitebuilder.git
if [ -d ${project_path}/${project_name} ]
then
  cd ${project_path}/${project_name}
  git pull
else
  mkdir -p ${project_path}
  cd ${project_path}
  git clone ${git_url}
fi

# compile java classes
ant -buildfile ${project_path}/${project_name}/build.xml

# update jdbc connection parameter
cd ${project_path}/${project_name}/WebContent/WEB-INF/classes/resource
sed -i -e 's/^jdbc.url=/#&/g' -e '/jdbc.url=/a jdbc.url=jdbc:mysql:\/\/127.0.0.1:3308\/superwebsitebuilder' jdbc-mysql.properties
sed -i -e 's/^jdbc.username=/#&/g' -e '/jdbc.username=/a jdbc.username=root' jdbc-mysql.properties
sed -i -e 's/^jdbc.password=/#&/g' -e '/jdbc.password=/a jdbc.password=abcd@1234' jdbc-mysql.properties

env=$1
if [ "${env}" = "prod" ]
then
  sed -i -e 's/^host_name=/#&/g' -e "/host_name=/a host_name=$(hostname)" host-and-application.properties
  sed -i -e 's/^host_ip=/#&/g' -e "/host_ip=/a host_ip=$(hostname -I)" host-and-application.properties
fi

# make the change of web.xml to inform tomcat there is something changed
webxml_file=${project_path}/${project_name}/WebContent/WEB-INF/web.xml
printf "\n<!-- $(date) add comments to trigger tomcat auto re-deployment -->" >>${webxml_file}

# update deployment to tomcats
find /wsworkenv/ -maxdepth 1 -type d -name "tomcat-*" |
while read tomcat_i
do
  rsync -rtv -P --delete --exclude 'logs' ${project_path}/${project_name}/WebContent/ ${tomcat_i}/webapps/${project_name}/
  chown -R tomcat:tomcat ${tomcat_i}/webapps/${project_name}
done
echo "end deploy superwebsitebuilder"

# deploy superwebsitebuilder
echo "start to deploy colorfulthemes"
project_name=colorfulthemes
# get latest source code from git
git_url=https://github.com/TwoPlus2017/colorfulthemes.git
if [ -d ${project_path}/${project_name} ]
then
  cd ${project_path}/${project_name}
  git pull
else
  mkdir -p ${project_path}
  cd ${project_path}
  git clone ${git_url}
fi

# update nginx themes
nginx_path=/wsworkenv/nginx-1.10.3
rsync -rtv -P --delete --exclude 'logs' ${project_path}/${project_name}/WebContent/domainsetup/ ${nginx_path}/domainsetup/
rsync -rtv -P --delete --exclude 'logs' ${project_path}/${project_name}/WebContent/wsworkspace/ ${nginx_path}/wsworkspace/
chown -R nginx:nginx ${nginx_path}

# make dir for nginx logs
for i in $(ls ${nginx_path}/domainsetup/) 
do
  mkdir -p /wsworkenv/runtimeLogs/nginxLogs/${i%.*}/dailyBackup
done

service nginx reload

echo "end deploy colorfulthemes"
