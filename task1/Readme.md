#Task 1

1. image is pushed to dockerhub ra4u12/task1:v1. I'm new to R and so i could not write much interms of very functional code to run, so its just a helloworld with sleep. considering the time i didnt invest much time in learning and writing better R code.

2. a. We could use a image from strach and install the only required packages, this would ensure we have small docker image. But making sure adding all the depdencies for complex project can be a challenge. Also using multiple stages to build can remove dependencies and other packages. Base image can be stored in  internal docker repo and CI/CD pipeline can fetch it quickly, which can reduce the build times.


3. I would recommend to use trivy tool to scan the image for all CVE, secret pill over and configs. Trivy can also scan base image from dockerhub repo before using it to build the docker image.
 `trivy image ra4u12/task1:v1`
  a. I would add the trivy scan as part of the CI/CD pipeline which would scan for vulnerabilities for every commit before the docker image is published. Also it is necessary to check for vulnerablities in the code before the build phase in CI/CD pipeline.

4. Created deployment.yaml file with argument passed as command to keep the pod running.

5. Created service.yaml and ingress.yaml to expose the service externally. assumming nginx ingress controller is in place, pocketlaw domain works, certs are added as secret to be used in ingress.
