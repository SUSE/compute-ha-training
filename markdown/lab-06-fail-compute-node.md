<!-- .slide: data-state="section-break" id="lab-6" data-menu-title="Lab 6: fail compute node" -->
# Lab 6: test compute node failover
## (the exciting bit!)


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


<!-- .slide: data-state="normal" id="verify-recovery" -->
## Verify recovery

* Ping to the VM is interrupted, then resumed
* Ping to the compute node is interrupted (then resumed)
* Log messages show:
  ```
  NovaEvacuate [...] Initiating evacuation
  NovaEvacuate [...] Completed evacuation
  ```
* `crm status` shows compute node offline (then back online)
* Verify compute node was fenced
  * Check `/var/log/messages` on DC
* Verify VM moved to another compute node
  ```sh
  nova list --fields host,name
  ```


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

