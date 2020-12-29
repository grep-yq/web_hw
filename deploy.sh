#!/bin/bash
## Automatically distinguish the environment
## Usage:  ./deploy.sh "<env>" "<private_key_file>"
## Owner: Grep

run_ansible_deploy(){
env=$1
private_key_file=$2
sed -i '/private_key_file/d' ansible.cfg
echo "private_key_file=${private_key_file}" >> ansible.cfg
ansible-playbook -i ./intentory/${env}.txt deploy.yaml -e ${env}
}

if [ "$1" == "test" ] || [ "$1" == "staging" ] || [ "$1" == "prod" ];then
  if [ -f "$2" ];then
    run_ansible_deploy $1 $2
  else
    echo 'Error: <private_key_file> is not exists,Please running:  ./deploy.sh "<env>" "<private_key_file>" '
    exit 3
  fi
else
  echo 'Error: Please running:  ./deploy.sh "<env>" "<private_key_file>"'
  exit 2
fi


