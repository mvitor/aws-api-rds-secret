# aws-api-rds-secret

The purpose of this exercise is to deploy a NodeJS Express application which is capable of retrieving a secret from AWS Secret Manager and to connect to a MySQL database. All resources should be deployed on AWS using Terraform.

- AWS Elastic Beanstalk Environment, Application and Versioning
- AWS IAM rules to allow multi-service communication
- - AWS S3 Bucket to keep the application code versioning 
- AWS Secret Manager to keep a application secret 
- AWS VPC/Subnets/Gateway - To allow Public and Private network access of services
- AWS RDS  to deploy a private MySQL database


During Terraform deployment, the application code is copied to S3 and then the new version is deployed into the EBS Environment.



