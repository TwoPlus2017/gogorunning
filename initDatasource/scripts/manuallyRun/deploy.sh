#!/bin/bash
project_path=/wsworkenv/projects
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
sed -i 's/jdbc.url=jdbc:mysql:\/\/127.0.0.1:xxx\/xxx/jdbc.url=jdbc:mysql:\/\/127.0.0.1:3308\/superwebsitebuilder/g' jdbc-mysql.properties
sed -i 's/jdbc.username=xxx/jdbc.username=root/g' jdbc-mysql.properties
sed -i 's/jdbc.password=xxx/jdbc.password=abcd@1234/g' jdbc-mysql.properties

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

