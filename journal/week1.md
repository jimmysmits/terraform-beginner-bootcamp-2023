# Terraform Beginner Bootcamp 2023 - Week 1

## Root module structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf               # everything else
├── variables.tf          # stores the structure of input variables
├── providers.tf          # defines required providers & configuration
├── outputs.tf            # stores the outputs
├── terraform.tfvars      # the data of variables we want to load into our Terraform project
└── README.md             # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
