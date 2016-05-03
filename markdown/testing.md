<!-- .slide: data-state="section-break" id="testing" data-menu-title="Testing" -->
# Testing


<!-- .slide: data-state="normal" id="create-vm" -->
## Create a VM

Let's create a VM to check evacuation/resurrection works.
Connect to one of the controller nodes.

```sh
source .openrc
openstack image list
openstack flavor list
neutron net-list
nova boot --image imageID --flavor flavorID --nic net-id=netID testvm
```

Let's get it a floating IP

```sh
neutron floatingip-create floatingnetID
nova list # get vmIP
neutron port-list | grep vmIP # get portID
neutron floatingip-associate floatingipID portID
```

The VM uses the default security group. Make sure it has ICMP.


<!-- .slide: data-state="normal" id="test-vm" -->
## Test VM

Things we can look at to check the recovery
* Recommended in separate windows/terminals
* From one on the controller nodes

Ping VM:
```
ping vmFloatingIP
```

Ping host where the VM is running
```
nova list --fields host,name
ping hostIP
```

Check log messages for Nova Evacuate workflow
```
tail -f /var/log/messages | grep NovaEvacuate
```

Monitor cluster status
```
crm_mon
```


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

