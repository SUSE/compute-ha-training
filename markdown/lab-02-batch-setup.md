<!-- .slide: data-state="section-break" id="crowbar-batch" data-timing="20" -->
# Intro to `crowbar batch`

Note:
`batch` is a subcommand of the `crowbar` client (typically
run on the admin node).


<!-- .slide: data-state="normal" id="batch-intro" data-menu-title="crowbar batch" data-timing="60" -->
## crowbar batch

<br/>
Unattended batch setup of barclamps:

```text
$ crowbar batch build my-cloud.yaml
```

<br/>
Dump current barclamps as YAML:

```text
$ crowbar batch export
```

Note:
- `batch build` is useful once you've learned the web UI.
- `batch export` is useful for debugging and reproducible deployments.


<!-- .slide: data-state="normal" id="batch-YAML" data-menu-title="Batch YAML" data-timing="120" -->
## YAML input for batch setup

```yaml
- barclamp: keystone
  attributes:
    api:
      region: 'CustomRegion'
  deployment:
    elements:
      keystone-server:
        - cluster:cluster1
- barclamp: glance
  deployment:
    elements:
      glance-server:
      - cluster:cluster1
```


<!-- .slide: data-state="normal" id="batch-aliases" data-menu-title="Alias expansion" data-timing="120" -->
## Node alias expansion

```yaml
- barclamp: cinder
  wipe_attributes:
    - volumes
  attributes:
    volumes:
      - backend_name: local
        backend_driver: local
        local:
          file_size: 2000
          volume_name: cinder-volumes
          file_name: "/var/lib/cinder/volume.raw"
  deployment:
    elements:
      cinder-controller:
      - cluster:cluster1
      cinder-volume:
      - "@@compute1@@"
```


<!-- .slide: data-state="section-break" id="lab-2" data-menu-title="Lab 2: batch setup" data-timing="5" -->
# Lab 2: batch setup other OpenStack services


<!-- .slide: data-state="normal" id="batch-openstack" data-menu-title="Setup OpenStack" data-timing="180" -->
## Setup the other OpenStack services

```sh
$ crowbar batch build up-to-nova.yaml
```

