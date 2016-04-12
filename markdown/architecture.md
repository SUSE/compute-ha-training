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
        *   introduces unwanted artificial boundaries

    *   Clusters inside / between guest VM instances
        *   requires cloud users to modify guest images <br />
            (installing & configuring cluster software)
        *   cluster stacks are not OS-agnostic

    <span class="fg-bright-orange">Cloud is supposed to make things
    easier not harder!</span>
