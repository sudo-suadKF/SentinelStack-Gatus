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
- Non-root user and small image footprint (47.4 MB) in 112s
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

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 541064517911.dkr.ecr.eu-west-2.amazonaws.com (logged in to the repository in ECR)
docker build -t gatus-ecs-project .
docker tag gatus-ecs-project:latest 541064517911.dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs-project:v1 (tagged with v1)
docker push 541064517911.dkr.ecr.eu-west-2.amazonaws.com/gatus-ecs-project:v1 (pushed to ECR)

4. AWS Infrastructure

Firstly, built the infrastructure in AWS with ClickOps. 

5. Terraform

I teared down the whole clickops infrastructure and then built it in Terraform with following stuff included: 

Terraform
- Add .terraform.lock.hcl to .gitignore. Done
- Move provider configuration into a separate provider.tf file. Done
- Reference values dynamically using data blocks (for Route 53 or Cloudflare IDs). Done
- Automate ACM certificate creation using a module or script. Done
- Add an HTTP → HTTPS redirect on the load balancer. Done
- Use an S3 backend with native state locking (DynamoDB optional). Done
- Create modules for VPC, ACM, ALB, ECS and Security Groups. Done
- Avoid hard-coded values — everything should be variable-driven and defined in .tfvars. Done
- Keep the code DRY and maintain consistent naming and tagging. Done

Minimum Resources
VPC with public subnets Done
ECS cluster + Fargate service Done
ECR repository Done
ALB + listener + target Group Done
ACM certificate Done
Route53 record for tm.<your-domain> Done
IAM roles/policies for ECS tasks Done
Security groups, SSM parameters if needed. Done

Bonus
Use S3 backend + DynamoDB locking Done




