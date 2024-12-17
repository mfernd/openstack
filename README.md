# Configuration management: Openstack

Small examples to experiment with Openstack.

## Plan

1. [Openstack on CLI](#01-openstack-on-cli), creating a simple compute instance
2. [Terraform](#02-terraform), creating a simple compute instance with a SSH access
3. Openstack with HEAT yaml...
4. Small project with `openstack LB` ➡️ `Front 1 | Front 2` ➡️ `Back`

## 01. Openstack on CLI

Requirements:

- Openstack CLI installed
- We assume that you have a working Openstack environment
- An Openstack key pair with your SSH public key  
  (replace `<YOU_KEY_PAIR_NAME>` with your key pair name)

```bash
$ openstack server create --flavor m1.small --image Debian-12 \
  --network default --security-group default \
  --key-name <YOU_KEY_PAIR_NAME> \
  myinstance --wait
```

You can replace the flavor and image with what you want to use.

## 02. Terraform

Simple compute instance accessible through SSH after its creation.

See it in the [`02_terraform/`](./02_terraform/) directory.

```bash
$ cd 02_terraform/

$ terraform init

$ cp .tfvars.dist .tfvars

$ terraform apply -var-file .tfvars
```

> [!NOTE]
> You can remove the variable [`openstack_provider_config`](./02_terraform/variables.tf), and instead use the argument `cloud` in your [openstack provider config](./02_terraform/providers.tf) to use your current Openstack environment.
>
> But personally, I prefer to specify the environment each time.
