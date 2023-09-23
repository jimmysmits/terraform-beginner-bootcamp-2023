# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage: 

This project is going to utilize semantic versioning for its tagging. [semver.org](https://semver.org/)

The general format:
**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes


## Install the Terraform CLI

### Consideridations with the Terraform CLI changes
The Terraform CLI installations instructions have changed due to pgp keyring changes. So we needed refer to the latest install CLI instructions via TF Documentation and change te scripting for install

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux distribution

This project is a build against Ubuntu. Please consider checking your Linux distribution and change accordingly to your distribution needs.
[How to check OS version of Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
```
$ cat /etc/os-release

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

While fixing the TF gpg deprecation issues, we noticed the bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the TF CLI. 

This bash script is located here: [./bin/install_terraform_cli][./bin/install_terraform_cli]

This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy
This will allow for an easier way to debug and execute manually  the TF CLI install
This will allow better portability for other projects that need to install the TF CLI

### Shebang considerations

A Shebang (pronounched Sha-bang) tells the bash script what programm will interpret the script, e.g. `#!/bin/bash`

For portability for different OS distributions - will search the user's PATH for the bash executable
`#!/usr/bin/env bash`

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution considerations

Whe executing the bash script we can use the `./` short hand notation to execute the bash script

e.g. `./bin/install_terraform_cli`. If we are using a script in `.gitpod.yml` we need to point the script to a program to interpret it

#### Linux permissions considerations

In order to make our bash scripts executable we need to change the Linux permission for the fix to be executable at the user mode

```sh
chmod u+x ./bin/install/terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### GitHub lifecycle (`before`, `init`, `command)

We need to be careful when using the `init` because it will not rerun if we restart an existing workspace

https://www.gitpod.io/docs/configure/workspaces/tasks

