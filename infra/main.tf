module "vpc" {
  source                   = "./modules/vpc"
  vpc-cidr                 = var.vpc-cidr
  vpc-tags                 = var.vpc-tags
  public-subnet1-cidr      = var.public-subnet1-cidr
  public-subnet1-tags      = var.public-subnet1-tags
  public-subnet2-cidr      = var.public-subnet2-cidr
  public-subnet2-tags      = var.public-subnet2-tags
  public-subnet3-cidr      = var.public-subnet3-cidr
  public-subnet3-tags      = var.public-subnet3-tags
  private-subnet1-cidr     = var.private-subnet1-cidr
  private-subnet1-tags     = var.private-subnet1-tags
  private-subnet2-cidr     = var.private-subnet2-cidr
  private-subnet2-tags     = var.private-subnet2-tags
  private-subnet3-cidr     = var.private-subnet3-cidr
  private-subnet3-tags     = var.private-subnet3-tags
  az1                      = var.az1
  az2                      = var.az2
  az3                      = var.az3
  igw-tags                 = var.igw-tags
  nat-gw-availability-mode = var.nat-gw-availability-mode
  nat-gw-connectivity-type = var.nat-gw-connectivity-type
  nat-gw-tags              = var.nat-gw-tags
  public-rt-tags           = var.public-rt-tags
  private-rt-tags          = var.private-rt-tags
  internet-cidr            = var.internet-cidr
}

module "sg" {
  source                           = "./modules/sg"
  vpc-id                           = module.vpc.vpc-id
  alb-sg-description               = var.alb-sg-description
  alb-sg-inbound-HTTP-description  = var.alb-sg-inbound-HTTP-description
  alb-sg-inbound-HTTPS-description = var.alb-sg-inbound-HTTPS-description
  alb-sg-outbound-description      = var.alb-sg-outbound-description
  alb-sg-tags                      = var.alb-sg-tags
  ecs-sg-description               = var.ecs-sg-description
  ecs-sg-inbound-description       = var.ecs-sg-inbound-description
  ecs-sg-outbound-description      = var.ecs-sg-outbound-description
  ecs-sg-tags                      = var.ecs-sg-tags
  internet-cidr                    = var.internet-cidr
  ip-protocol-1                    = var.ip-protocol-1
  ip-protocol-tcp                  = var.ip-protocol-tcp
  port-http                        = var.port-http
  port-https                       = var.port-https
  port-app                         = var.port-app
}

module "alb" {
  source                           = "./modules/alb"
  alb-name                         = var.alb-name
  alb-sg-id                        = module.sg.alb-sg-id
  alb-tags                         = var.alb-tags
  listener-http-action-port        = var.listener-http-action-port
  listener-http-action-protocol    = var.listener-http-action-protocol
  listener-http-action-status-code = var.listener-http-action-status-code
  listener-http-action-type        = var.listener-http-action-type
  listener-http-port               = var.listener-http-port
  listener-http-protocol           = var.listener-http-protocol
  listener-https-action-type       = var.listener-https-action-type
  listener-https-port              = var.listener-https-port
  listener-https-protocol          = var.listener-https-protocol
  listener-https-ssl-policy        = var.listener-https-ssl-policy
  public-subnet1-id                = module.vpc.public-subnet1-id
  public-subnet2-id                = module.vpc.public-subnet2-id
  public-subnet3-id                = module.vpc.public-subnet3-id
  health-check-interval            = var.health-check-interval
  health-check-matcher             = var.health-check-matcher
  health-check-path                = var.health-check-path
  health-check-port                = var.health-check-port
  health-check-protocol            = var.health-check-protocol
  health-check-timeout             = var.health-check-timeout
  health-check-unhealthy-threshold = var.health-check-unhealthy-threshold
  healthy-threshold                = var.healthy-threshold
  vpc-id                           = module.vpc.vpc-id
  tg-attach-port                   = var.tg-attach-port
  tg-ip-type                       = var.tg-ip-type
  tg-name                          = var.tg-name
  tg-port                          = var.tg-port
  tg-protocol                      = var.tg-protocol
  tg-target-type                   = var.tg-target-type
  lb-type                          = var.lb-type
  certificate-arn                  = module.acm.certificate-arn
  logs-prefix                      = var.logs-prefix 
  depends_on                       = [module.acm]
  bucket-name                      = var.bucket-name
}

module "acm" {
  source            = "./modules/acm"
  hosted-zone-name  = var.hosted-zone-name
  domain-name       = var.domain-name
  record-ttl        = var.record-ttl
  validation-method = var.validation-method
}

module "route53" {
  source           = "./modules/route53"
  alb-dns-name     = module.alb.alb-dns-name
  alb-zone-id      = module.alb.alb-zone-id
  domain-name      = var.domain-name
  hosted-zone-name = var.hosted-zone-name
  record-type      = var.record-type
}

module "ecs" {
  source             = "./modules/ecs"
  ecs-sg-id          = module.sg.ecs-sg-id
  execution-role-arn = module.iam.execution-role-arn
  tg-arn             = module.alb.tg-arn
  private-subnets-ids = [
    module.vpc.private-subnet1-id, module.vpc.private-subnet2-id, module.vpc.private-subnet3-id
  ]
  image-uri                 = module.ecr.image-uri
  aws-region                = var.aws-region
  port-app                  = var.port-app
  port-mapping-protocol     = var.port-mapping-protocol
  cpu-size                  = var.cpu-size
  memory-size               = var.memory-size
  setting-name              = var.setting-name
  setting-value             = var.setting-value
  requires-compatibilities  = var.requires-compatibilities
  aws-stream-prefix         = var.aws-stream-prefix
  log-config-driver         = var.log-config-driver
  cluster-name              = var.cluster-name
  cloudwatch-name           = var.cloudwatch-name
  cloudwatch-retention-days = var.cloudwatch-retention-days
  network-mode              = var.network-mode
  task-family               = var.task-family
  container-name            = var.container-name
  platform-version          = var.platform-version
  launch-type               = var.launch-type
  service-name              = var.service-name
  desired-count             = var.desired-count
}

module "ecr" {
  source          = "./modules/ecr"
  repository-name = var.repository-name
}

module "iam" {
  source        = "./modules/iam"
  iam-role-name = var.iam-role-name
  policy-arn    = var.policy-arn
}