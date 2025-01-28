# Openstack on Ansible

Prérequis :
- Add Ansible OpenStack Collection
- Set variables in [`vars/`](./vars/external_vars.yaml.dist)

```sh
$ ansible-galaxy collection install -r requirements.yml

$ cp ./vars/external_vars.yaml.dist ./vars/external_vars.yaml

$ vim ./vars/external_vars.yaml
```

## Execute playbook

```sh
$ ansible-playbook playbook.yaml
```

And you can check that the VM instance has been created with:

```sh
$ openstack server list
```
