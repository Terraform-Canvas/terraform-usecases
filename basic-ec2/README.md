# Basic EC2
Simple EC2 Setting for testing terraform.

## Architecture
![image](https://github.com/Terraform-Canvas/terraform-usecases/assets/16442978/75ecc051-d3f1-4085-962a-d2f91cf0e69f)

## How to Run
1. Initialize your terraform configuration.
```
terraform init
```
2. Preview your configuration.
```
terraform plan
```
3. Apply your terraform configuration.
```
terraform apply
```
If it run successfully, you should be able to see the instance in the EC2 console.

4. Destroy your resources
```
terraform destroy
```

## Reference
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build