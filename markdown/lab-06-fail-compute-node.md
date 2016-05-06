<!-- .slide: data-state="section-break" id="lab-6" data-menu-title="Lab 6: fail compute node" -->
# Lab 6: fail a compute node


<!-- .slide: data-state="normal" id="simulate-down" -->
## Simulate Compute Node Down

Login to compute node where VM runs

```
pkill -f pacemaker_remote
```

or

```
reboot
```


<!-- .slide: data-state="normal" id="recovery-monitor" -->
## Recovery Monitor

* Ping to the VM is interrupted, but is resumed
* Ping to the Compute Node is interrupted, but is resumed
* Log Messages show:
  * NovaEvacuate [...] Initiating evacuation
  * NovaEvacaute [...] Completed evacuation
* `crm status` shows compute node offline, then back online
* check VM is in another compute node
  * nova list --fields host,name


<!-- .slide: data-state="normal" id="shared-storage" -->
## Shared Storage

Previous test was done without shared storage:
* VM will be resurrected from base image
* Files written to VM disk have been lost

To fix this
* Put `/var/lib/nova/instances` in shared storage for all computes


<!-- .slide: data-state="normal" id="sample-shared-storage" -->
## Sample Shared Storage

Only for testing purposes. Actual solution better be based on distributed storage and redundant NFS servers.

Admin node already export /srv/nfs

Mount export in controller nodes
```
admin$ mkdir /srv/nfs/instances
compX$ mount adminNodeIP:/srv/nfs/instances /var/lib/nova/instances
```

