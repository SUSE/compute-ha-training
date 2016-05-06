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


<!-- .slide: data-state="normal" id="floating-ip" -->
## Assign a floating IP

Create floating IP:

<pre>
neutron floatingip-create <em>floatingnetID</em>
</pre>

Get VM IP:

<pre>
nova list
</pre>

Get port id:

<pre>
neutron port-list | grep vmIP
</pre>

Associate floating IP with VM port:

<pre>
neutron floatingip-associate <em>floatingipID portID</em>
</pre>


<!-- .slide: data-state="normal" id="allow-icmp" -->
## Allow ICMP

The VM uses the `default` security group. Make sure it has ICMP.


<!-- .slide: data-state="normal" id="setup-monitoring" -->
## Set up monitoring

* Recommended in separate windows/terminals
* From either of the controller nodes

Ping VM:

<pre>
ping <em>vmFloatingIP</em>
</pre>

Ping host where the VM is running:

<pre>
nova list --fields host,name
ping <em>hostIP</em>
</pre>


<!-- .slide: data-state="normal" id="setup-monitoring-2" -->
## Set up monitoring (part 2)

Check log messages for `NovaEvacuate` workflow:

```
tail -f /var/log/messages | grep NovaEvacuate
```

Monitor cluster status:

```
crm_mon
```
