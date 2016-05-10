<!-- .slide: data-state="section-break" id="crowbar-batch" data-timing="20" -->
# Intro to `crowbar batch`

Note:
`batch` is a subcommand of the `crowbar` client (typically
run on the admin node).


<!-- .slide: data-state="normal" id="batch-intro" data-menu-title="crowbar batch" data-timing="60" -->
## crowbar batch

<br/>
Unattended batch setup of barclamps:

```
root@crowbar:~ # crowbar batch build my-cloud.yaml
```

<br/>
Dump current barclamps as YAML:

```
root@crowbar:~ # crowbar batch export
```

Note:
- `batch build` is useful once you've learned the web UI.
- `batch export` is useful for debugging and reproducible deployments.


<!-- .slide: data-state="normal" id="batch-remotes" data-menu-title="Remotes YAML" data-timing="120" -->
## YAML for Pacemaker remotes

```yaml
- barclamp: pacemaker
  name: services
  attributes:
    stonith:
      mode: libvirt
      libvirt:
        hypervisor_ip: 192.168.217.1
    drbd:
      enabled: true
  deployment:
    elements:
      hawk-server:
      - "@@controller1@@"
      - "@@controller2@@"
      pacemaker-cluster-member:
      - "@@controller1@@"
      - "@@controller2@@"
      pacemaker-remote:
      - "@@compute1@@"
      - "@@compute2@@"
```


<!-- .slide: data-state="normal" id="batch-nova" data-menu-title="nova YAML" data-timing="120" -->
## YAML input for KVM remote nodes

```yaml
- barclamp: nova
  attributes:
    use_migration: true
    kvm:
      ksm_enabled: true
  deployment:
    elements:
      nova-controller:
      - cluster:cluster1
      nova-compute-kvm:
      - remotes:cluster1
```
