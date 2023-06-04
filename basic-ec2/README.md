# Basic EC2
Basic EC2 Setting for testing terraform.

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