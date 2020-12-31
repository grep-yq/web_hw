#!/bin/bash
#######################################################
## Automatically distinguish the environment
## Usage:  ./deploy.sh "<env>" "<private_key_file>"
## Owner: Quan
## Create time: 2020/12/31   Quan
#######################################################

cd $(dirname $0)
WORK_HOME=$(pwd)
NOW_TIME=$(date +%Y%m%d%H%M%S)


run_ansible_deploy(){
env=$1
private_key_file=$2

cd ${WORK_HOME}/ansible/
sed -i '/private_key_file/d' ansible.cfg
echo "private_key_file=${private_key_file}" >> ansible.cfg
echo """
release_env: ${env}
docker_image_version: ${NOW_TIME}
""" > env_var.yml
ansible-playbook -i ./intentory/${env}.txt deploy.yaml -e @env_var.yml
rm -f env_var.yml
cd ${WORK_HOME}
}

BUILD_NGINX_STATIC_IMAGE(){
cd ${WORK_HOME}/Dockerfile/static
docker build -t 192.168.242.91:5000/nginx:${NOW_TIME} .
docker push 192.168.242.91:5000/nginx:${NOW_TIME}
cd ${WORK_HOME}
}

BUILD_TOMCAT_DYNAMIC_IMAGE(){
cd ${WORK_HOME}/Dockerfile/dynamic
docker build -t 192.168.242.91:5000/tomcat:${NOW_TIME} .
docker push 192.168.242.91:5000/tomcat:${NOW_TIME}
cd ${WORK_HOME}
}

if [ "$1" == "test" ] || [ "$1" == "staging" ] || [ "$1" == "prod" ];then
  if [ -f "$2" ];then
    BUILD_NGINX_STATIC_IMAGE
    BUILD_TOMCAT_DYNAMIC_IMAGE
    run_ansible_deploy $1 $2
  else
    echo 'Error: <private_key_file> is not exists,Please running:  ./deploy.sh "<env>" "<private_key_file>" '
    exit 3
  fi
else
  echo 'Error: Please running:  ./deploy.sh "<env>" "<private_key_file>"'
  exit 2
fi


