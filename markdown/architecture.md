<!-- .slide: data-state="section-break" id="architecture" -->
# Architectural challenges


<!-- .slide: data-state="normal" id="scalability" class="scalability" data-menu-title="Scalability" -->
## Compute plane needs to scale

<figure>
    <img alt="CERN datacenter"
         data-src="images/CERN-datacenter.jpg" />
     <figcaption>
         CERN datacenter
         <a href="https://www.flickr.com/photos/torkildr/3462607995">
             (c) Torkild Retvedt CC-BY-SA 2.0
         </a>
     </figcaption>
</figure>

Note:

Clouds will often scale to *many* compute nodes
- 100s, or even 1000s


<!-- .slide: data-state="normal" id="peer-to-peer" class="scalability" data-menu-title="Peer to peer" -->
## Peer-to-peer clusters don't scale

<figure>
    <img alt="full mesh peer-to-peer network"
         data-src="images/full-mesh-network.svg" />
</figure>

Note:

Typical clustering software is peer-to-peer,
*   e.g. `corosync` requires <= 32 nodes


<!-- .slide: data-state="normal" id="scalability-workarounds" class="scalability" data-menu-title="Bad workarounds" -->
## Addressing Scalability

The obvious workarounds are *ugly*!

*   Multiple compute clusters introduce unwanted artificial boundaries
*   Clusters inside / between guest VM instances are not OS-agnostic,
    and require cloud users to modify guest images (installing & configuring cluster software)
*   <span class="fg-bright-orange bold">Cloud is supposed to make things
    easier not harder!</span>


<!-- .slide: data-state="normal" id="common-architecture" data-menu-title="Architecture" class="architecture" -->
## Common architecture

<div class="architecture">
    <img alt="Architecture with pacemaker_remote"
         class="architecture"
         data-src="images/standard-architecture.svg" />

    <img alt="Architecture with pacemaker_remote arrows"
         class="architecture fragment"
         data-src="images/standard-architecture-remote-arrows.svg" />
</div>

Note:
Scalability issue solved by `pacemaker_remote`

*   New(-ish) Pacemaker feature
*   Allows core cluster nodes to control "remote"
    nodes via a `pacemaker_remote` proxy service (daemon)
*   Can scale to very large numbers


<!-- .slide: data-state="normal" id="reliability" class="architecture" -->
## Reliability challenges

<div class="architecture">
    <img alt="Architecture with pacemaker_remote"
         class="architecture"
         data-src="images/standard-architecture.svg" />
    <span class="fragment" data-fragment-index="1">
        <img class="fragment fade-out compute-node bang"
             data-fragment-index="2"
             alt="compute node explosion!"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="2">
        <img class="fragment fade-out fence"
             data-fragment-index="3"
             alt="fencing dead compute node"
             data-src="images/cross.svg" />
        <img class="fragment fade-out migration"
             data-fragment-index="3"
             alt="resurrecting dead VMs elsewhere"
             data-src="images/migration-arrow.svg" />
    </span>
    <span class="fragment" data-fragment-index="3">
        <img class="fragment fade-out kernel bang"
             data-fragment-index="4"
             alt="kernel / OS crash or hang"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="4">
        <img class="fragment fade-out fence"
             data-fragment-index="5"
             alt="fencing dead compute node"
             data-src="images/cross.svg" />
        <img class="fragment fade-out migration"
             data-fragment-index="5"
             alt="resurrecting dead VMs elsewhere"
             data-src="images/migration-arrow.svg" />
    </span>
    <span class="fragment" data-fragment-index="5">
        <img class="fragment fade-out libvirt bang"
             data-fragment-index="6"
             alt="libvirt crash or hang"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="6">
        <img class="fragment fade-out nova-compute bang"
             data-fragment-index="7"
             alt="nova-compute crash or hang"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="7">
        <img class="fragment fade-out nova-api bang"
             data-fragment-index="8"
             alt="nova-api crash or hang"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="8">
        <img class="fragment fade-out recovery bang"
             data-fragment-index="9"
             alt="recovery controller crash or hang"
             data-src="images/explosion.svg" />
    </span>
    <span class="fragment" data-fragment-index="9">
        <img class="fragment fade-out VM bang"
             data-fragment-index="10"
             alt="VM crash or hang"
             data-src="images/explosion.svg" />
    </span>
        <img class="fragment workload bang"
             data-fragment-index="10"
             alt="workload crash or hang"
             data-src="images/explosion.svg" />
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
