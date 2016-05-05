<!-- .slide: data-state="section-break" id="SOC-solution" data-timing="5" -->
# Solution in SUSE OpenStack Cloud


<!-- .slide: data-state="normal" id="ocf-architecture" data-menu-title="OCF RAs" class="architecture" data-timing="90" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

<div class="architecture">
    <img alt="Standard architecture with pacemaker_remote"
         class="architecture fragment fade-out" data-fragment-index="1"
         data-src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="OCF RA architecture"
             class="OCF-RA architecture fragment fade-out" data-fragment-index="2"
             data-src="images/OCF-RA-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="OCF RA failure domains"
             class="OCF-RA architecture"
             data-src="images/OCF-RA-failure-domains.svg" />
    </span>
</div>

Note:
*   Custom OCF Resource Agents (RAs)
    *   Pacemaker plugins to manage resources
*   Custom fencing agent (`fence_compute`) flags host for recovery
*   `NovaEvacuate` RA polls for flags, and initiates recovery
    *   Will keep retrying if recovery not possible
*   `NovaCompute` RA starts / stops `nova-compute`
    *   Start waits for recovery to complete


<!-- .slide: data-state="normal" id="RHEL-OSP-article" data-timing="30" -->
## RHEL OSP support

<div class="row">
    <div class="col-md-6 article">
        <img alt="Article on setting up compute HA with RHEL OSP" class="full-slide"
             data-src="images/RHEL-OSP-HA-article.png" />
    </div>
    <div class="col-md-6 instructions">
        <img alt="Article on setting up compute HA with RHEL OSP" class="full-slide"
             data-src="images/RHEL-OSP-HA-instructions.png" />
    </div>
</div>

Note: OCF RA approach is supported in RHEL OSP. Setup is manual;
here is a fragment of the installation instructions.


<!-- .slide: data-state="blank" id="SOC-demo" data-menu-title="SOC demo" data-timing="200" -->
<video controls class="my-stretch">
    <source data-src="video/kdenlive/Austin-short.ogv" />
    <!-- This video demoing compute node HA in SUSE OpenStack Cloud will be uploaded to YouTube soon!" -->
    Sorry - it seems your browser doesn't support embedded video via HTML5.
</video>


<!-- .slide: data-state="normal" id="ocf-pros-cons" data-menu-title="OCF RA pros and cons" data-timing="30" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

### Pros

*   Ready for production use *now*
*   Commercially supported by SUSE
*   RAs [upstream in `openstack-resource-agents` repo](https://github.com/openstack/openstack-resource-agents/tree/master/ocf)

### Cons

*   Known limitations (not bugs):
    *   Only handles failure of compute node, not of VMs, or `nova-compute`
    *   Some corner cases still problematic, e.g. if `nova` fails during recovery
