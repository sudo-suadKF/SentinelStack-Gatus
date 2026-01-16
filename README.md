# gatus-ecs-project

1. Application setup

Created a directory where I cloned the repo. Then I deleted the .git folder to remove the clone from the gatus repo and to be able to connect to my own repo by:

mkdir gatus-ecs-project
git clone git@github.com:TwiN/gatus.git
cd gatus
rm -rf .git
cd ..
git init
echo "# gatus-ecs-project" >> README.md
git add .
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:sudo-suadKF/gatus-ecs-project.git
git push -u origin main

Then I used the developer's own dockerfile to build an image and run a container to check if the app is up and running by following commands:

cd gatus (enter the app's directory)
docker build -t test:latest . (build the image of the dockerfile)
docker run -d --name testlocal -p 8080:8080 test:latest (build and run a container of the image)

then I checked the status by:
curl http://localhost:8080/health
response:
{"status":"UP"}%

2. Containerisation

Created a dockerfile that does the following:
- Multistage file
- Non-root user and small image footprint (47.4 MB) in 97s
- a scratch image as final image

by running following commands:

docker build -t gatus:latest .
docker run -d --name gatusapp -p 8080:8080 gatus:latest

added .dockerignore for:
- faster builds
- smaller image sizes
- better security

3. Image Registry ECR

The working image for the app is pushed to ECR for storing the image. 
This is done because later ECS will pull the image from ECR to run the app. 
First a private repository is created in ECR and then the image is pushed by following commands:

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin "aws account id".dkr.ecr.eu-west-2.amazonaws.com (logged in to the repository in ECR)
docker build -t gatus-ecs-project .
docker tag gatus-ecs-project:latest "aws account id".dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs-project:v1 (tagged with v1)
docker push "aws account id".dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs-project:v1 (pushed to ECR)

4. AWS Infrastructure

Firstly, built the infrastructure in AWS with ClickOps. 
My infrastrucutre includes:
- a VPC with 3 AZs and a public and private subnet in each AZ.
- an internet gateway that inbounds internet traffic
- a regional nat gateway that outbounds traffic from the infrastructure.
- a multi AZ ALB, in every AZs/public subnet, collecting the inbound traffic HTTP and HTTPS from internet gateway, redirects the HTTP to HTTPS.
- an ecs service and cluster with Fargate, across all private subnets/AZs, receiving traffic from ALB, running a task in each private subnet and fetching the docker image from ECR.
- an ECR repository with the docker image stored.
- a CloudWatch log group for receiving live logs from the ECS service
- a SSL certificate for HTTPS to the ALB's domain tm.sudosuad.co.uk
- a route53 record for the domain tm.sudosuad.co.uk.
- two security groups, one for ALB and one for ECS
- a target group that targets the ecs tasks and guides the traffic from alb to the tasks.
- two listeners, one for HTTP and one for HTTPS.
- an iam role for ecs task execution role which allows the tasks to execute...


5. Terraform

Teared down the whole clickops infrastructure and then built it in Terraform with following stuff included: 

- a provider configuration with s3 backend, a s3 bucket for storing the terraform state file and a dynamoDB state locking
- the whole infrastructure modularised in each modules, ALB, VPC, ACM. ECR, ECS, IAM, Route53 and SG
- all hard-coded values variablised and defined in root variable.tf file
- the code was kept DRY with consistent naming and tagging.


6. CI/CD pipelines

Created 4 pipelines for each purpose:

- One pipeline for building and pushing the docker image to ECR with Trivy scanner that checks the for any vulnerabilities in the docker image. Since the image is built with scratch and is basically distroless, there were no vulnerabilities. 

- One pipeline for Terraform linting, running init, fmt, validate and plan commands. Checkov action is included right before running the plan to check for any security issues.

- One pipeline for Terraform apply, running apply command to build the infrastructure in AWS. Checkov action is included  right before running the apply to check for any security issues. 

- One pipeline for Terraform destroy, running destroy command to destroy the infrastructure in AWS. 

All the pipelines above are:
- built with workflow dispatch that asks the user to type in 'yes' to run the pipelines. 
- configured with a safety check before checking the code to see if the user has typed 'yes' to continue, otherwise if something else is typed then the code will stop and exit.
- configured with OIDC to connect to AWS by creating a new identity provider and an IAM role in AWS manually and linking the policy to this repository and main branch. 



7. Security and Networking implementation
- ECS tasks running within private subnets.
- A regional NAT Gateway to allow ECS outbound traffic.
- Restrict security groups (ALB allows ports 80/443; ECS accepts traffic only from the ALB security group).
- Enabled HTTPS by default.
- Used IAM roles with least-privilege access for ECS and pipelines.
- Incorporated security scanning tools such as Trivy and Checkov.


8. Repository infrastructure


