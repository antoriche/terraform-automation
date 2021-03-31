# Terraform automation

This project aim to create template for repetitive infrastructure parterns

## Install

```
curl https://raw.githubusercontent.com/antoriche/terraform-automation/master/install | sh
```

## Usage

### Create infrastructure manually

First create an account on [terraform cloud](https://app.terraform.io/) and create or join an organization

```
terraform-automation create react-app MyOrganization MyAwesomeProject-dev
```

The script above will ask you for some informations that might be repetitive on update

### Create infrastructure with a config file

You can keep your configuration into a file

```
{
    "name": "MyAwesomeProject-dev",
    "organisation": "MyOrganization",
    "template": "react-app",
    "variables":{
        "repository":"https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/my-awesome-project",
        "branch":"develop",
        "env_vars":{
            "REACT_APP_API_URL":"https://api.my-awesome-project.org",
        }
    }
}
```

and deploy with

```
terraform-automation apply-config infra.json
```
