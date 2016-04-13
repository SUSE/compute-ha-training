<!-- .slide: data-state="section-break" id="solutions" -->
# Existing solutions


<!-- .slide: data-state="normal" id="ocf" data-menu-title="OCF RAs" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

*   Custom OCF Resource Agents (RAs)
    *   Pacemaker plugins to manage resources
*   Used by Red Hat / SUSE / Intel
*   Custom fencing agent (`fence_compute`) flags host for recovery
*   `NovaEvacuate` RA polls for flags, and initiates recovery
    *   Will keep retrying if recovery not possible
*   `NovaCompute` RA starts / stops `nova-compute`
    *   Start waits for recovery to complete
*   RAs
    [upstream in `openstack-resource-agents` repo](https://github.com/openstack/openstack-resource-agents/tree/master/ocf)
    (maintained by me)


<!-- .slide: data-state="normal" id="pacemaker_remote" data-menu-title="pacemaker_remote" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

Scalability issue solved by `pacemaker_remote`

*   New(-ish) Pacemaker feature
*   Allows core cluster nodes to control "remote"
    nodes via a `pacemaker_remote` proxy service (daemon)
*   Can scale to very large numbers


<!-- .slide: data-state="normal" id="ocf-architecture" data-menu-title="architecture" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

<img alt="Architecture with pacemaker_remote" class="full-slide"
     src="images/pacemaker_remote.svg" />


<!-- .slide: data-state="normal" id="ocf-2" data-menu-title="Pros and cons" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

### Pros

*   Ready for production use *now*
*   Commercial support available
*   Tolerates simultaneous failures in compute / control planes

### Cons

*   Known limitations (not bugs):
    *   Only handles failure of compute node, not of VMs, or `nova-compute`
    *   Some corner cases still problematic, e.g. if control plane fails during recovery


<!-- .slide: data-state="normal" id="masakari" -->
# Masakari

*   https://github.com/ntt-sic/masakari
*   Developed by NTT
*   Similar architectural concept, different code
    *   Recovery handled by separate service
    *   Persists state to RDBMS
*   Monitors for 3 types of failure:
    *   compute node down
    *   `nova-compute` service down
    *   VM down (detected via `libvirt`)
*   Recently switched to `pacemaker_remote` and SQLAlchemy


<!-- .slide: data-state="normal" id="masakari-arch" -->
# Masakari architecture

<img alt="masakari architecture" src="images/masakari-architecture.png" 
     class="full-slide" />


<!-- .slide: data-state="normal" id="mistral" -->
# Mistral resurrection workflow

*   https://github.com/gryf/mistral-evacuate
*   Congruous with upstream OpenStack strategy

*   Mistral


<!-- .slide: data-state="normal" id="awcloud-china-mobile" -->
# AWcloud / China Mobile

*   Very different solution
*   [Presented in Tokyo](https://youtu.be/nz4kEZcmxr4)
*   Uses Consul / raft / gossip instead of Pacemaker
*   Fencing via IPMI / self-fencing
*   Has some interesting capabilities
    *   gossip potentially more resilient than peer-to-peer
    *   action matrix: configurable per failure mode
*   But source code not available :-(


<!-- .slide: data-state="normal" id="senlin" -->
# Senlin

*   https://wiki.openstack.org/wiki/Senlin
*   Started in ~ June 2015 (by IBM?)
*   Aiming to provide a generic clustering service (HAaaS)


<!-- .slide: data-state="normal" id="zerostack" -->
# ZeroStack

*   [Presented in Tokyo](https://youtu.be/F0P1ueq05a8)
*   Proprietary hosted solution
*   Adaptive, self-healing approach
    *   Every node is be dynamically (re-)assigned a role
        *   Could switch from controller to compute based on demand
    *   Much harder to lose quorum, since non-voting nodes can
        be promoted to voting status
