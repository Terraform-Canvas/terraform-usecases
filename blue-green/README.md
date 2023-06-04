# Blue-Green Deployment
Blue-Green Deployments.

## Architecture
![image](https://github.com/Terraform-Canvas/terraform-usecases/assets/16442978/d8f1b132-cef1-4250-b607-ff7ead5c8e85)
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

4. Verify environment   


You can test enviroment by visiting LB's DNS name.
```
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```

5. Routing traffic   


You can see more info for traffic_distribution variables to `locals` of  `variables.tf`  

```
terraform apply -var 'traffic_distribution=blue-90'
```

6. Destroy your resources   

You need to remember  traffic_distribution variables for destroying  resources
```
terraform destroy var 'traffic_distribution=blue-90'
```

## Reference
- https://developer.hashicorp.com/terraform/tutorials/aws/blue-green-canary-tests-deployments#blue-green-canary-tests-deployments