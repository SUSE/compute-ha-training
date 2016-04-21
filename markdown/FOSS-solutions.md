<!-- .slide: data-state="section-break" id="FOSS-solutions" -->
# Existing F/OSS solutions


<!-- .slide: data-state="normal" id="ocf-architecture" data-menu-title="OCF RAs" class="architecture" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

<div class="architecture">
    <img alt="Standard architecture with pacemaker_remote"
         class="architecture fragment fade-out" data-fragment-index="1"
         src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="OCF RA architecture"
             class="OCF-RA architecture fragment fade-out" data-fragment-index="2"
             src="images/OCF-RA-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="OCF RA failure domains"
             class="OCF-RA architecture"
             src="images/OCF-RA-failure-domains.svg" />
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


<!-- .slide: data-state="normal" id="RHEL-OSP-article" -->
## RHEL OSP support

<div class="row">
    <div class="col-md-6 article">
        <img alt="Article on setting up compute HA with RHEL OSP" class="full-slide"
             src="images/RHEL-OSP-HA-article.png" />
    </div>
    <div class="col-md-6 instructions">
        <img alt="Article on setting up compute HA with RHEL OSP" class="full-slide"
             src="images/RHEL-OSP-HA-instructions.png" />
    </div>
</div>

Note: OCF RA approach is supported in RHEL OSP. Setup is manual;
here is a fragment of the installation instructions.


<!-- .slide: data-state="blank" id="SOC-demo" data-menu-title="SOC demo" -->
<video class="stretch" src="video/OCF-demo.ogv"></video>


<!-- .slide: data-state="normal" id="ocf-pros-cons" data-menu-title="OCF RA pros and cons" -->
## `NovaCompute` / `NovaEvacuate` OCF agents

### Pros

*   Ready for production use *now*
*   Commercial support available
*   RAs [upstream in `openstack-resource-agents` repo](https://github.com/openstack/openstack-resource-agents/tree/master/ocf)

### Cons

*   Known limitations (not bugs):
    *   Only handles failure of compute node, not of VMs, or `nova-compute`
    *   Some corner cases still problematic, e.g. if `nova` fails during recovery


<!-- .slide: data-state="normal" id="masakari-architecture" class="architecture" -->
## Masakari architecture

<div class="architecture">
    <img alt="Standard architecture with pacemaker_remote"
         class="architecture fragment fade-out" data-fragment-index="1"
         src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="masakari architecture"
             class="masakari architecture fragment fade-out" data-fragment-index="2"
             src="images/masakari-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="masakari failure domains"
             class="masakari architecture"
             src="images/masakari-failure-domains.svg" />
    </span>
</div>

Note:

*   Similar architectural concept, different code
    *   Recovery handled by separate controller service
    *   Persists state to database
*   Monitors for [3 types of failure](https://github.com/ntt-sic/masakari/blob/master/docs/evacuation_patterns.md):
    *   compute node down
    *   `nova-compute` service down
    *   VM down (detected via `libvirt`)


<!-- .slide: data-state="normal" id="masakari-installation" -->
## Masakari installation

*   https://github.com/ntt-sic/masakari
*   [1.1.0 release](https://github.com/ntt-sic/masakari/releases/tag/1.1.0):
    `pacemaker_remote`, CentOS, SQLAlchemy
*   Requires manual compilation of `pacemaker_remote` on Ubuntu 14.04


<!-- .slide: data-state="normal" id="masakari-pros-cons" -->
## Masakari analysis

### Pros

*   Monitors VM health (externally)
*   More sophisticated recovery workflows

### Cons

*   Looser integration with pacemaker

Note:
- Failing `nova-compute` service will be disabled
- Basically only uses Pacemaker as monitoring / fencing service
- Waits 5 minutes after fencing


<!-- .slide: data-state="normal" id="mistral-architecture" data-menu-title="Mistral" class="architecture" -->
## Mistral-based resurrection workflow

<div class="architecture">
    <img alt="Standard architecture with pacemaker_remote"
         class="architecture fragment fade-out" data-fragment-index="1"
         src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="mistral architecture"
             class="mistral architecture fragment fade-out" data-fragment-index="2"
             src="images/mistral-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="mistral failure domains"
             class="mistral architecture"
             src="images/mistral-failure-domains.svg" />
    </span>
</div>


<!-- .slide: data-state="normal" id="mistral-summary" data-menu-title="Mistral summary" -->
## Mistral-based resurrection workflow

*   https://github.com/gryf/mistral-evacuate

### Pros

*   Congruous with upstream OpenStack strategy
*   Clean, simple approach
*   Potential for integration with Congress for policy-based workflows

### Cons

*   Still experimental code; not yet usable by most
*   Mistral resilience WIP

Note:
Reuses components rather than adding yet another project


<!-- .slide: data-state="normal" id="senlin" -->
# Senlin

*   https://wiki.openstack.org/wiki/Senlin
*   Fairly new project
*   Clustering service for OpenStack
*   Orchestration of collections of similar objects
*   Policies for placement / load-balancing / health / scaling etc.


<!-- .slide: data-state="normal" id="comparison" data-menu-title="Comparison" -->
## F/OSS solution functionality comparison

<table class="waffle" cellspacing="0" cellpadding="0">
  <thead>
    <tr>
      <th class="criterion-class">
        <div></div>
      </th>
      <th class="criteria" />
      <th>OCF Agents</th>
      <th>Masakari</th>
      <th>Mistral</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="criterion-class policy" rowspan="2">
        <div>Policy</div>
      </td>
      <td class="criteria">Support for tagging VM for evacuation</td>
      <td class="no">No</td>
      <td class="yes">Yes</td>
      <td class="yes">Yes</td>
    </tr>
    <tr>
      <td class="criteria">Customizable actions based on failure</td>
      <td class="no">No</td>
      <td class="no">No</td>
      <td class="no">Planned (via Congress)</td>
    </tr>
    <tr>
      <td class="criterion-class resilience" rowspan="2">
        <div>Resilience</div>
      </td>
      <td class="criteria">Service is self-resilient</td>
      <td class="yes">Yes</td>
      <td class="yes">Yes</td>
      <td class="maybe">In progress</td>
    </tr>
    <tr>
      <td class="criteria">Monitoring of VM's (external) health</td>
      <td class="no">No</td>
      <td class="yes">Yes</td>
      <td class="no">No</td>
    </tr>
    <tr>
      <td class="criterion-class recovery" rowspan="4">
        <div>Recovery</div>
      </td>
      <td class="criteria">Uses force-down API</td>
      <td class="yes">Yes</td>
      <td class="no">No</td>
      <td class="no">Planned</td>
    </tr>
    <tr>
      <td class="criteria">Disable failed `nova‑compute`</td>
      <td class="no">No</td>
      <td class="yes">Yes</td>
      <td class="no">No</td>
    </tr>
    <tr>
      <td class="criteria">Evacuation in parallel</td>
      <td class="no">No</td>
      <td class="no">No</td>
      <td class="yes">Yes</td>
    </tr>
  </tbody>
</table>

Note:

Common functionality:
*   Tolerate simultaneous failures in compute / control planes
*   Retry failed evacuations
*   Monitor node and hypervisor health

