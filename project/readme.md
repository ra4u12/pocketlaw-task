# Project

The respository is an answer to project from pocketlaw.

In this project, you will be tasked with setting up and managing a Kubernetes cluster that
automatically handles up/down scaling and resource allocation while ensuring efficient
resource utilization across multiple teams, resources, and projects. The cluster should
also monitor resource usage and notify when resources are idle or underutilized,
downsizing as needed. Additionally, you need to implement data tracking and
performance evaluation mechanisms.

## Answers inline

1. Cluster Setup:
a. Set up a Kubernetes cluster with multiple instance groups to accommodate
different resource requirements.

Answer: Created eks cluster with two nodegroups to accomodate different resource requirement.

b. Implement taints and tags to segregate resource usage between teams,
resources, and projects.

Answer: Have added appropriate labels to all the nodegroups and taints to nodegroup2

2. Resource Provisioning:
a. Configure the cluster to allocate resources dynamically based on the
requirements of applications.

Answer: configured ebs csi driver and storage class to dynamically allocate storage.

b. Ensure processes requiring between 100-250GB of storage are provisioned
appropriately

Answer: execute `kubectl apply -f project2`

3. Resource Monitoring:
a. Implement resource monitoring system that tracks resource usage and ensures
accurate resource requests compared to actual usage.

Answer: Have used container insights to track resource usage. Go to cloudwatch > container insights and select the cluster to get all resource data.

4. Resource Optimization:
a. Establish rules and thresholds for automatic up/down scaling based on usage
patterns and resource availability.

Answer: Have used HPA for resource based scaling. scaling strategy used to cpu utlization over 50%.
`kubectl apply -f project4`
use test-hpa.txt to generate load.
I wanted to use the cloudwatch metrics to be used for HPA, but solution from aws was deprecated and didnt have much time to investigate. I will comeback to you on this solution.

5. Notification System:
a. Set up a notification system to alert administrators when resources are idle or
underutilized.

Answer: Have created cloudwatch alert over all ec2 instances to alert when cpu utilization is less than or equal to 50%
Go to sns and approve the subscription for email alert.
Go to cloudwatch to check the alert.

6. Data Logging and Analysis:
a. Implement a system to log resource requests, usage, and performance metrics.
b. Create a dashboard or reporting mechanism to evaluate the performance of the
environment.

Answer: Cloudwatch metrics and logging is implemented to log resources requests and performance metrics.
Cloudwatch dashboard is created few basics metrics. I had an alternative solution to use prometheus, grafana and loki.But went a head with native solution of aws.

## Approach to the solution
I have used terraform to setup the eks cluster in aws. Used modules approach to create most of the resources.
eks - https://github.com/terraform-aws-modules/terraform-aws-eks
iam - https://github.com/terraform-aws-modules/terraform-aws-iam
monitoring and logging - https://github.com/shamimice03/terraform-aws-eks-monitoring-logging ( modified to work with eks module)
metrics - helm chart https://github.com/kubernetes-sigs/metrics-server/tree/master/charts

Rancher was a solution which i had in my mind to manage the cluster which has most of the solutions inbuilt. But the challange with rancher is it needs already existing k8 cluster or local cluster has pre-requisit. We can manage clusters from different cloud providers and also VMware.

## Instructions to execute
### Pre-requisites:

1. Setup terraform, aws cli, kubectl , helm , eksctl , infracost and any other required tools.
2. Configure aws cli with user having permissions to eks,cloudwatch, iam, ec2 and other services if needed.
3. Configure locals.tf with approriate values like vpic_cidr, regions more.

Steps:
1. Execute terraform init to initialize. i have not added s3 backend and lock for this project. so the state file will be present locally.
`terraform init`
2. Execute terraform plan to validate and check the resources being created.
`terraform plan -out=FILE_NAME -input=false`

If you would like to know the approximate cost for the execution use infracost: optional

`terraform show -json FILE_NAME > plan.json`

 `infracost breakdown --path plan.json`

3. Apply the changes
`terraform apply -input=false FILE_PATH`



