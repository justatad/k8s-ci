#!/bin/bash
mkdir ~/.kube
mv ./build-scripts/kubeconfig ~/.kube/config
 
#decrypt the large secrets
openssl aes-256-cbc -K $encrypted_55aec6d91b66_key -iv $encrypted_55aec6d91b66_iv -in ./build-scripts/large-secrets.txt.enc -out build-scripts/large-secrets.txt -d

# run the script to get the secrets as environment variables
source ./build-scripts/large-secrets.txt
export $(cut -d= -f1 ./build-scripts/large-secrets.txt)
 
echo $CERTIFICATE_AUTHORITY_DATA 
# Set kubernetes secrets
./kubectl config set clusters.cluster.zigzag-london.net.certificate-authority-data $CERTIFICATE_AUTHORITY_DATA
./kubectl config set users.cluster.zigzag-london.net.client-certificate-data "$CLIENT_CERTIFICATE_DATA"
./kubectl config set users.cluster.zigzag-london.net.client-key-data "$CLIENT_KEY_DATA"
./kubectl config set users.cluster.zigzag-london.net.password "$KUBE_PASSWORD"
./kubectl config set users.cluster.zigzag-london.net-basic-auth.password "$KUBE_PASSWORD"
 
# set AWS secrets
mkdir ~/.aws
touch ~/.aws/credentials
echo '[default]' >> ~/.aws/credentials
echo "aws_access_key_id = $AWS_KEY">> ~/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_KEY" >> ~/.aws/credentials
 
# set AWS region
touch ~/.aws/config
echo '[default]' >> ~/.aws/config
echo "output = json">> ~/.aws/config
echo "region = eu-west-1" >> ~/.aws/config
