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

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal (e.g. AWS credentials)
- Terraform Variables - those that you would normally set in your `.tfvars` file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_uuid"`

### var-file flag

- TODO: Document this flag

### terraform.tvfars

This is the default file to load in Tterraform variables in bulk

### auto.tfvars

- TODO: Document this functionality for Terraform Cloud

### order of terraform variables

- TODO: Document which Terraform variables takes precedence

## Dealing with configuration drift

If you lose your state files, you most likely have to tear down all you cloud infrastructure manually

You can use Terraform import but it will not work for all cloud resources. You need to check the Terraform providers documentation

### Fix missing resourcers with Terraform import

[Terraform import](https://developer.hashicorp.com/terraform/language/import)

`terrafrom import aws_s3_bucket.bucket bucket-name`

[AWS S3 bucket import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix manual configuration

- If someone goes and delete or modifies cloud resource manually through ClickOps. 
- If we run Terraform plan with the attampt to put the infrastructure back into the expected state (fixing configuration drift)

## Fix using Terraform refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform modules

### Terraform module structure

It is recommended to place modules in a `modules` directory when eveloping modules locally 

### Passing input variables

```tf
module "terrahouse_aws" {
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

We can pass input variables into our module. The module has to declare the Terraform variables in its own `variables.tf`

### Module sources

[Moudle sources](https://developer.hashicorp.com/terraform/language/modules/sources)

Using the source we can import the module from various place (locally, GitHub, Terraform Registry)

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"clear
}
```