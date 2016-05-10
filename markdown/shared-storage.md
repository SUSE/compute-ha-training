<!-- .slide: data-state="section-break" id="shared-storage" -->
# Shared storage


<!-- .slide: data-state="normal" id="shared-storage-where" data-menu-title="Shared directories" -->
## Where can we have shared storage?

Two key areas:

* `/var/lib/glance/images` on *controller* nodes
* `/var/lib/nova/instances` on *compute* nodes


<!-- .slide: data-state="normal" id="shared-storage-needed" data-menu-title="When needed" -->
## When do we need shared storage?

If `/var/lib/nova/instances` is shared:
* VM's ephemeral disk will be preserved during recovery

Otherwise:

* VM disk will be lost
* recovery will need to rebuild VM from image

Either way, `/var/lib/glance/images` should be shared across
all controllers (unless using Swift / Ceph)

* otherwise `nova` might fail to retrieve image from `glance`


<!-- .slide: data-state="normal" id="setup-shared-storage" data-menu-title="Lab setup" -->
## How `crowbar batch` set up shared storage

We're using admin server's NFS server:

* Only suitable for testing purposes!
* In production, use SES / SAN


<!-- .slide: data-state="normal" id="verify-shared-storage" data-menu-title="Verify setup" -->
## Verify setup of shared storage

* Locate shared directories via `nfs_client` barclamp
* Check `/etc/exports` on admin server
* Check `/etc/fstab` on controller / compute nodes
* Run `mount` on controller / compute nodes
