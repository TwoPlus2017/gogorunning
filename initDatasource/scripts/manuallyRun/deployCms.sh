#!/bin/bash
project_path=/wsworkenv/projects

# deploy cms
echo "start to deploy cms"
project_name=twoplus
# get latest source code from git
git_url=https://github.com/TwoPlus2017/twoplus.git
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

# make the change of web.xml to inform tomcat there is something changed
webxml_file=${project_path}/${project_name}/WebContent/WEB-INF/web.xml
printf "\n<!-- $(date) add comments to trigger tomcat auto re-deployment -->" >>${webxml_file}

# update deployment to tomcats
find /wsworkenv/ -maxdepth 1 -type d -name "tomcat-8093" |
while read tomcat_i
do
  rsync -rtv -P --delete --exclude 'logs' ${project_path}/${project_name}/WebContent/ ${tomcat_i}/webapps/${project_name}/
  chown -R tomcat:tomcat ${tomcat_i}/webapps/${project_name}
done
echo "end deploy cms"
