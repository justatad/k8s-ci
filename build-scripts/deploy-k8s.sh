#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0;0m'
export PATH=$PATH:$(pwd)
echo -e "${GREEN}==== Deploying RBAC role ====${NC}"
ls
cd ..
ls
cd rbac
for f in $(find ./ -name '*.yaml' -or -name '*.yml'); do kubectl apply -f $f --validate=false; done
echo -e "${GREEN}==== Done deploying iam role ====${NC}"
echo ''
