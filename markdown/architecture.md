<!-- .slide: data-state="section-break" id="architecture" -->
# Architectural challenges


<!-- .slide: data-state="normal" id="scalability" -->
## Scalability

*   Clouds will often scale to *many* compute nodes
    * 100s, or even 1000s
*   Typical <!-- .element: class="fragment" -->
    clustering software is peer-to-peer
    *   e.g. `corosync` requires <= 32 nodes
*   The <!-- .element: class="fragment" -->
    obvious workarounds are *ugly*!
    *   Multiple compute clusters
    *   Clusters inside / between guest VM instances
    *   <span class="fg-bright-orange bold">Cloud is supposed to make things
        easier not harder!</span>

Note:
-   multiple clusters introduce unwanted artificial boundaries
-   clusters inside guests not OS-agnostic, require cloud users
    to modify guest images (installing & configuring cluster software)


<!-- .slide: data-state="normal" id="common-architecture" data-menu-title="Architecture" -->
## Common architecture

<div class="architecture">
    <img alt="Architecture with pacemaker_remote"
         src="images/standard-architecture.svg" />

    <img alt="Architecture with pacemaker_remote arrows"
         class="fragment"
         src="images/standard-architecture-remote-arrows.svg" />
</div>

Note:
Scalability issue solved by `pacemaker_remote`

*   New(-ish) Pacemaker feature
*   Allows core cluster nodes to control "remote"
    nodes via a `pacemaker_remote` proxy service (daemon)
*   Can scale to very large numbers


<!-- .slide: data-state="normal" id="reliability" -->
## Reliability challenges

<div class="architecture">
    <img alt="Architecture with pacemaker_remote"
         src="images/standard-architecture.svg" />
    <span class="fragment" data-fragment-index="1">
        <img class="fragment fade-out compute-node bang"
             data-fragment-index="2"
             alt="compute node explosion!"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="2">
        <img class="fragment fade-out fence bang"
             data-fragment-index="3"
             alt="fencing dead compute node"
             src="images/cross.svg" />
        <img class="fragment fade-out migration bang"
             data-fragment-index="3"
             alt="resurrecting dead VMs elsewhere"
             src="images/migration-arrow.svg" />
    </span>
    <span class="fragment" data-fragment-index="2">
        <img class="fragment fade-out kernel bang"
             data-fragment-index="3"
             alt="kernel / OS crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="3">
        <img class="fragment fade-out libvirt bang"
             data-fragment-index="4"
             alt="libvirt crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="4">
        <img class="fragment fade-out nova-compute bang"
             data-fragment-index="5"
             alt="nova-compute crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="5">
        <img class="fragment fade-out nova-api bang"
             data-fragment-index="6"
             alt="nova-api crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="6">
        <img class="fragment fade-out recovery bang"
             data-fragment-index="7"
             alt="recovery controller crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="7">
        <img class="fragment fade-out VM bang"
             data-fragment-index="8"
             alt="VM crash or hang"
             src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="8">
        <img class="fragment fade-out workload bang"
             data-fragment-index="9"
             alt="workload crash or hang"
             src="images/explosion.svg" />
    </span>
</div>

Note:

*   Needs to protect critical data ⇒ requires *fencing* of either
    *   storage resource, *or*
    *   of faulty node (a.k.a. **STONITH**)

*   Needs to handle failure or (temporary) freeze of:
    *   Hardware (including various NICs)
    *   Kernel
    *   Hypervisor services (e.g. `libvirt`)
    *   OpenStack control plane services
        *   including resurrection workflow
    *   VM
    *   Workload inside VM (ideally)

We assume that Pacemaker is reliable, otherwise we're sunk!


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
