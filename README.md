# Terraform Beginner Bootcamp 2023

## Semantic versioning :mage: 

This project is going to utilize semantic versioning for its tagging. See: [semver.org](https://semver.org/).

The general format is as follows;
**MAJOR.MINOR.PATCH**, e.g. `1.0.1`, where:
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Consideridations with the Terraform CLI changes

The Terraform CLI installations instructions have changed due to pgp keyring changes. So we needed refer to the latest install CLI instructions (TF documentation and change) the scripting for the install. 

See: [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

### Considerations for Linux distribution

This project is a build against Ubuntu. Please consider checking your Linux distribution and change accordingly to your distribution needs. See: [How to check OS version of Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/).

_Example of checking the OS version_

**Command:**
```
$ cat /etc/os-release
```

**Output:**
```
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into bash scripts

While fixing the TF gpg deprecation issues, we noticed the bash scripts steps were a considerable amount of new code. So we decided to create a bash script to install the TF CLI. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli).

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow for an easier way to debug and execute manually  the TF CLI install
- This will allow better portability for other projects that need to install the TF CLI

### Shebang considerations

A Shebang (pronounched Sha-bang) tells the bash script what program will interpret the script, e.g. `#!/bin/bash`.

For portability for different OS distributions - the following command will search the user's PATH for the bash executable; `#!/usr/bin/env bash`.

See: https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution considerations

When executing the bash script we can use the `./` short-hand notation to execute the bash script.

e.g. `./bin/install_terraform_cli`. If we are using a script in `.gitpod.yml` we need to point the script to a program to interpret it

#### Linux permissions considerations

In order to make our bash scripts executable we need to change the Linux permission for the fix to be executable at the user mode

```sh
chmod u+x ./bin/install/terraform_cli
```

See: https://en.wikipedia.org/wiki/Chmod

### GitHub lifecycle (before, init, command)

We need to be careful when using the `init` because it will not rerun if we restart an existing workspace

See: https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with env vars

We can list out all environment variables (env vars) using the `env` command
We can filter specific env vars using grep, e.g. `env | grep AWS_`

### Setting and unsetting env vars

- In the terminal we can set using `export HELLO='world'`
- In the terminal we unset using `unset HELLO`
- We can set an env var temporarily when just running a command

```sh
HELLO='world ./bin/print_message
```

Within in a bash script we can set an env var without writing export e.g.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing env vars

We can print an env var using echo, e.g. `echo $HELLO`

#### Scoping of env vars

When you open new bash terminal in VSCode it will not be aware of env vars that you have set in another tab/window. If you want env vars to persist across all future bash terminal that are open you need to set env vars in your bash profile, e.g. `.bash_profile`.

#### Persisting env vars in Gitpod

We can persist env var into Gitopod by storing them in Gitpod Secrets Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml`, but this can only contain non-sensitive  env vars.

### AWS CLI installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started with installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
We can check if our AWS credentials are configured correctly by running the following command:

```sh
aws sts get-caller-identity
```

If it is successfull you should see a json payload return that looks like this:

```json
{
    "UserId": "XXXXXX",
    "Account": "XXXXXX",
    "Arn": "arn:aws:iam::XXXXXX:user/terraform-beginner-bootcamp"
}
```

We will need to generate AWS CLI credentials from IAM user.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in TF
- **Modules** are a way to make a large amount of TF code modular, portable and shareable

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`.

#### Terraform init

At the start of a new Terraform project we will run `terraform init` to download the binaries to  for the Terraform providers that we will use in the project.

#### Terraform plan

`terraform plan` will generate a change set about the state of our infrastructure and what will be changed. We can output this change set i.e. plan to be passed to an an apply. But often you can just ignore outputting.

#### Terraform apply

`terraform apply` wil run a plan and pass the change set to be executed by Terraform. Apply should prompt a yes or no. If we want to automaically approve an apply we can provide the auto approve flag e.g. `terraform apply --auto-approve`.

#### Terraform destory

`terraform destroy` will destroy resources. You can also use the auto approve flag to skip the approve prompt, e.g. `terraform destroy --auto-approve`

### Terraform lock files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform lock file should be committed to your version control system (VSC), e.g. GitHub.

### Terraform state files

`terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be commited** to your VCS. This file can contain sensitive data. If you lose this file, you lose the state of your infrastructure.

`terraform.tfstate.backup` is the previous state of the infrastructure.

### Terraform directory

`.terraform` directory contains binaries of Terraform providers.