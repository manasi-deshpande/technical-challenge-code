terraform init -var-file="envs/dev.tfvars" -backend-config="envs/dev-backend.tfvars"
terraform plan -var-file="envs/dev.tfvars" -out="plan.out"