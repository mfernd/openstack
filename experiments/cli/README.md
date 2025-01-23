# Openstack on CLI

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
