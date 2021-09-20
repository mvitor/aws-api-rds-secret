# EB Service
variable "service_name" {
  default = "My application"
}


variable "solution_stack" {
  default = "64bit Amazon Linux 2 v5.4.5 running Node.js 14"
  description = "Elastic Beanstalk environment name."
}
variable "name" {
  default = "EB-App"
  description = "Elastic Beanstalk environment name."
}
variable "service_description" {
  default = "My Application Service Description"
}
variable "env" {
  default = "dev"
  description = "(dev, stage, prod)"
}
variable "environmentType" {
  default = "UseLoadBalancer"
  description = "Set to SingleInstance to launch one EC2 instance with no load balancer."
}
variable "ec2_policies" {
  default = [
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}
variable "beanstalk_policies" {
  default = [
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
  ]
}
variable "namespace" {
  default = "mywepapps"
  description = "Apps namespace"
}
variable "api_dist" {
  default = "app"
  description = "Api Distribution folder"
}
variable "dist_zip" {
  default = "app.zip"
  description = "APP package"
}
# Auto Scaling
variable "as_breach_duration" {
  default = "5"
  description = "Amount of time, in minutes, a metric can be beyond its defined limit (as specified in the UpperThreshold and LowerThreshold) before the trigger fires."
}
variable "as_lower_breach_scale_increment" {
  default = "-1"
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}
variable "as_lower_threshold" {
  default = "2000000"
  description = "If the measurement falls below this number for the breach duration, a trigger is fired."
}
variable "as_measure_name" {
  default = "NetworkOut"
  description = "Metric used for your Auto Scaling trigger."
}
variable "as_period" {
  default = "5"
  description = "Specifies how frequently Amazon CloudWatch measures the metrics for your trigger."
}
variable "as_statistic" {
  default = "Average"
  description = "Statistic the trigger should use, such as Average."
}
variable "as_unit" {
  default = "Bytes"
  description = "Unit for the trigger measurement, such as Bytes."
}
variable "as_upper_breachs_scale_increment" {
  default = "1"
  description = "How many Amazon EC2 instances to add when performing a scaling activity."
}
variable "as_upper_threshold" {
  default = "6000000"
  description = "If the measurement is higher than this number for the breach duration, a trigger is fired."
}
variable "port" {
  default = "8080"
  description = "The instance port"
}
variable "ssl_certificate_id" {
  default = ""
  description = "ARN of an SSL certificate to bind to the listener."
}
variable "healthcheck_url" {
  default = "HTTP:8080/healthcheck"
  description = "The path to which to send health check requests."
}
variable "healthcheck_healthy_threshold" {
  default = "3"
  description = "Consecutive successful requests before Elastic Load Balancing changes the instance health status."
}
variable "healthcheck_unhealthy_threshold" {
  default = "5"
  description = "Consecutive unsuccessful requests before Elastic Load Balancing changes the instance health status."
}
variable "healthcheck_interval" {
  default = "10"
  description = "The interval at which Elastic Load Balancing will check the health of your application's Amazon EC2 instances."
}
variable "healthcheck_timeout" {
  default = "5"
  description = "Number of seconds Elastic Load Balancing will wait for a response before it considers the instance nonresponsive."
}

variable "ignore_healthcheck" {
  default = "true"
  description = "Do not cancel a deployment due to failed health checks. (true | false)"
}
variable "healthreporting" {
  default = "basic"
  description = "Health reporting system (basic or enhanced). Enhanced health reporting requires a service role and a version 2 platform configuration."
}
variable "notification_topic_arn" {
  default = ""
  description = "Amazon Resource Name for the topic you subscribed to."
}
variable "enable_http" {
  default = "true"
  description = "Enable or disable default HTTP connection on port 80."
}
variable "enable_https" {
  default = "true"
  description = "Enable or disable HTTPS connection on port 443."
}
variable "elb_connection_timeout" {
  default = "60"
  description = "Number of seconds that the load balancer waits for any data to be sent or received over the connection."
}

variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AWS_USERID" {
  default = "592243908108"
}
variable "SSH_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}
variable "app_version" {
  default = ""
}
variable "env_name" {
  default = ""
}