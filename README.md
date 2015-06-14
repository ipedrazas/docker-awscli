Docker awscli
=============

A container to run awcli and s3cmd command. This repo triggers autobuild and the image is available as suet/awscli. 

Usage example
=============

Check software versions:

```
core@n1 docker run --rm  suet/awscli aws --version
aws-cli/1.7.34 Python/2.7.9 Linux/4.0.3
```

```
core@n1 docker run --rm  suet/awscli 3cmd --version
s3cmd version 1.5.2
```

Copy data from s3 bucket to local file system:

```
/usr/bin/docker run --rm -v /var/apps:/apps suet/awscli:latest aws s3 cp --recursive s3://<bucket>/apps/nginx/ /apps/nginx
```

Registry an AWS instance to load balancer:

Pass in AWS credential (not needed if the instances has IAM role based permission):
```
sudo more /root/.aws/envvars
AWS_ACCESS_KEY_ID=<key id>
AWS_SECRET_ACCESS_KEY=<access key>
AWS_DEFAULT_REGION=us-west-2
```

```
#!/bin/bash
AWS_CONFIG_ENV=/root/.aws/envvars
INSTANCE=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id)
IMAGE=suet/awscli:latest

CMD="aws elb register-instances-with-load-balancer \
    --load-balancer-name <elb name> --instances $INSTANCE "

docker pull $IMAGE
docker run --rm --env-file=$AWS_CONFIG_ENV $IMAGE /bin/bash -c "$CMD"
```
