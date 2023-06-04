# Auto Scailing using AWS
Build auto scailing group for scale in-out.

## Architecture
![image](https://github.com/Terraform-Canvas/terraform-usecases/assets/16442978/7dbee1f7-5665-4480-ba77-0663a845b5d9)

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
- https://developer.hashicorp.com/terraform/tutorials/aws/aws-asg
