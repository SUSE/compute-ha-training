<!-- .slide: data-state="section-break" id="lab-5" data-menu-title="Lab 5: Boot a VM" -->
# Lab 5: Boot a VM


<!-- .slide: data-state="normal" id="boot-vm" -->
## Boot a VM

Let's boot a VM to test compute node HA!

Connect to one of the controller nodes, and get image / flavor / net ids:

<pre>
source .openrc
openstack image list
openstack flavor list
neutron net-list
</pre>

Boot the VM using these ids:

<pre>
nova boot --image <em>imageID</em> --flavor <em>flavorID</em> --nic net-id=<em>netID</em> testvm
</pre>

Test it's booted:

<pre>
nova show testvm
</pre>

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
