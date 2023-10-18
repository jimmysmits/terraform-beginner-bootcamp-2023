# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing tags

[How to delete local and remote tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Delete a tag local
```sh
$ git tag -d <tag_name>
```

Delete a tag remote
```sh
$ git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the SHA from your GitHub histroy

```sh
git checkout <SHA>
git tag m.m.p
git push --tags
git checkout main
```

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

## Considerations when using ChatGPT to write Terraform

LLM such as ChatGPT may not be trained on the latest documention or information about Terraform (since it is last update in 2021)

It may likely produce older examples that could be depcrated (this often affects the providers, since they change more often)

## Working with files in Terraform

### fileexists function

This is a built-in Terrafom function to check the existence of a a file

```tf
  validation {
    condition     = fileexists(var.index_html_file_path)
    error_message = "The specified index.html file path is not a valid file or does not exist."
  }
```

[fileexists function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### filemd5 function

filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.

[filemd5 function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path variable

In Terraform ther is special variable called `path` that allows us to referece local paths
- `pat.module` - get the path for the current module
- `pat.root` - get the path for the root module

[Special path variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = ${path.root}/public/index.html
}
```

## Terraform Locals

```tf
locals {
    s3_origin_id = "MyS3Origin"
}

```

[Local values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform data sources

This allows us to source data from cloud resources. This is useful when we want to reference cloud resources without importing them.

[Data sources](https://developer.hashicorp.com/terraform/language/data-sources)

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Example above](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
