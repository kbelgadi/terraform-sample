# terraform-sample

This sample terraform configuration creates an AWS EC2 machine and underlying infrastructure: VPC, Subnet, Internet Gateway and Security groups.

It stores .tfstate file in an AWS S3 bucket. 
If you wont to do it like this, remove the configuration file remote.tf from your directory prior to apply.

### Initialize configuration
From your terraform configuration directory:
```shell
terraform init
```

### Check your terraform configuration
```shell
terraform plan
```

### Provision your infrastructure
```shell
terraform apply
```

Result:
```shell
...
  tags.Name:                    "" => "bastion"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.instance-bastion: Still creating... (10s elapsed)
aws_instance.instance-bastion: Still creating... (20s elapsed)
aws_instance.instance-bastion: Creation complete after 23s (ID: i-06d39b66f77e99659)

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

public_ip = w.x.y.z
```

### Destroy everything
```shell
terraform destroy
```