terraform {
        backend "s3" {
                bucket="solistelo-devops"
                key="terraform/lab/terraform.tfstate"
                region="eu-west-3"
                profile = "terraform-test"
        }
}
