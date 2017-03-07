#!/bin/bash
# must specify the domain name to be generated.
if [ "$1" = "" ]; then
  echo "Uage: generateDomainConf.sh domainname"
  exit
fi

# constant
domains_base_dir=/wsworkenv/nginx-1.10.3/domainsetup
template_domain_name=gbtest.com
template_domain_key=gbtest
template_domain_str=gbtestcom
template_domain_index=000
template_domain_ip=8100
template_domain_conf=${template_domain_index}_${template_domain_str}.conf

# generate new domain paramters
new_domain_name=$1

# the first part(end at the first '.') of the domain name
new_domain_key=$(echo ${new_domain_name} | cut -d'.' -f 1)

# the full domain anme without '.'
new_domain_str=${new_domain_name//./}

# find the last index of domains
last_domain_conf=$(ls ${domains_base_dir}/*.conf | xargs -n 1 basename | sort -d | tail -1)
last_domain_index=$(echo ${last_domain_conf} | cut -d'_' -f 1)
# increase the number
new_domain_index=$((last_domain_index+1))
# make it three byte digital
new_domain_index=$(printf "%03d" ${new_domain_index})

# find the last ip/port of the domains
last_domain_ip=$(grep listen ${domains_base_dir}/${last_domain_conf} | sed 's/ //g' | cut -c 7-10)
new_domain_ip=$((last_domain_ip+1))

new_domain_conf=${new_domain_index}_${new_domain_str}.conf
# generate new domain files
cd ${domains_base_dir}
cp ${template_domain_conf} ${new_domain_conf}
# replace parameters
sed -i -e "s/${template_domain_name}/${new_domain_name}/g" ${new_domain_conf}
sed -i -e "s/${template_domain_key}/${new_domain_key}/g" ${new_domain_conf}
sed -i -e "s/${template_domain_str}/${new_domain_str}/g" ${new_domain_conf}
sed -i -e "s/${template_domain_index}/${new_domain_index}/g" ${new_domain_conf}
sed -i -e "s/${template_domain_ip}/${new_domain_ip}/g" ${new_domain_conf}

# create work dirs for the new domain
mkdir -p /wsworkenv/runtimeLogs/nginxLogs/${new_domain_str}
mkdir -p /wsworkenv/nginx-1.10.3/wsworkspace/hatcatwebsites/${new_domain_str}/theme
