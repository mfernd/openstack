# Openstack on HEAT Templates

Simple compute instance accessible through SSH after its creation.

```bash
# and edit the parameters
$ cp params.yaml.dist params.yaml

$ openstack stack create mystack --template main.yaml --environment params.yaml
```

> [!TIP]
> To use the `stack` commands, you need to have installed the heat plugin for the openstack CLI:
>
> With APT: `sudo apt install python3-heatclient`
> 
> With pip: `pipx python-heatclient`
