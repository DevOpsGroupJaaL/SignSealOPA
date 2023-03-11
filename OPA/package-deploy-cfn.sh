#!/bin/bash
# 'package-deploy-cfn.sh' Automates the process to build and deploy a container to ECR.
# EXAMPLE: ./package-deploy-cfn.sh us-east-1 helloopa-root my-bucket my-stack my-env
if [ $# -eq 0 ]; then
   echo "No arguments supplied"
   echo "Usage:<script name> region bucket_name stack_name environment"
   exit 1
fi
declare -r Region=$1
declare -r S3BucketName=$2
declare -r StackName=$3
declare -r EnvironmentName=$4
# This command will create a packaged CloudFormation template, uploads any nested stacks to given S3 Bucket.
aws cloudformation package --region ${Region} --template-file ./templates/signsealopa-root.yml --output-template ./templates/packed-signsealopa-root.yml --s3-bucket ${S3BucketName}
# This command will deploy your packed CloudFormation template
aws cloudformation deploy --region ${Region} --template-file templates/packed-signsealopa-root.yml --stack-name ${StackName} --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM CAPABILITY_IAM --parameter-overrides EnvironmentName=${EnvironmentName} VpcCIDR=10.10.0.0/16 PublicCIDRA=10.10.10.0/24 PublicCIDRB=10.10.11.0/24
/bin/bash

exit 0;

