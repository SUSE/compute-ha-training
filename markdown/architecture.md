<!-- .slide: data-state="section-break" id="architecture" -->
# Architectural challenges


<!-- .slide: data-state="normal" id="reliability" -->
## Reliability challenges

*   Needs to protect critical data ⇒ requires *fencing* of either
    *   storage resource, *or*
    *   of faulty node (a.k.a. **STONITH**)
*   Needs to handle failure or (temporary) freeze of:
    *   Hardware (including various NICs)
    *   Kernel
    *   OpenStack services
    *   Hypervisor services (e.g. `libvirt`)
    *   VM
    *   Workload inside VM (ideally)
    *   Control plane (including resurrection workflow)


<!-- .slide: data-state="normal" id="configurability" -->
## Configurability

Different cloud operators will want to support different SLAs
with different workflows, e.g.

*   Protection for pets:
    *   per AZ?
    *   per project?
    *   per *pet*?
*   If `nova-compute` fails, VMs are still perfectly healthy
    but unmanageable
    *   Should they be automatically killed?  Depends on
        the workload.

Note: There is no one-size-fits-all solution to compute HA.


<!-- .slide: data-state="normal" id="scalability" -->
## Scalability

*   Clouds will often scale to *many* compute nodes
    * 100s, or even 1000s
*   Typical clustering software is peer-to-peer
    *   e.g. `corosync` requires <= 32 nodes
*   The obvious workarounds are *ugly*!
    *   Multiple compute clusters
    *   Clusters inside / between guest VM instances
    *   <span class="fg-bright-orange bold">Cloud is supposed to make things
        easier not harder!</span>

Note:
-   multiple clusters introduce unwanted artificial boundaries
-   clusters inside guests not OS-agnostic, require cloud users
    to modify guest images (installing & configuring cluster software)
