<!-- .slide: data-state="section-break" id="FOSS-solutions" data-timing="5" -->
# Existing F/OSS solutions


<!-- .slide: data-state="normal" id="ocf-architecture" data-menu-title="OCF RAs" class="architecture" data-timing="5" -->
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


<!-- .slide: data-state="normal" id="RHEL-OSP-article" -->
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
    This video demoing compute node HA in SUSE OpenStack Cloud will be uploaded to YouTube soon!
</video>


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
         data-src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="masakari architecture"
             class="masakari architecture fragment fade-out" data-fragment-index="2"
             data-src="images/masakari-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="masakari failure domains"
             class="masakari architecture"
             data-src="images/masakari-failure-domains.svg" />
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


<!-- .slide: data-state="normal" id="mistral" data-menu-title="Mistral" data-timing="60"-->
## Mistral
*   Workflow as a service
*   Enables user to create any workflows
*   May be expansible with custom action
*   Workflow execution may be triggered by:
    *   events from ceilometer
    *   at a certain time (cloud cron)
    *   on demand (API call)

Note:
Next solution is based on mistral. Before I proceed with explaining this solution, I would like to tell you what Mistral is.
As you already read, mistral is 'workflow as a service' service. By using it, you can define a set of tasks and connect them into logical graph. For each task, you can define what to do in case of failure or success. Moreover, if predefined tasks are not enaugh for you, you can write your own actions and plugin them into mistral. Those actions are literaly python class, so you can do anything inside of them.
Once workflow is created, it can be triggered by varius ways. Ceilometer, time, or, what is used in instance-ha misrtal based solution, on demand via API.


<!-- .slide: data-state="normal" id="mistral-architecture" data-menu-title="Mistral" class="architecture" data-timing="60"-->
## Mistral-based resurrection workflow

<div class="architecture">
    <img alt="Standard architecture with pacemaker_remote"
         class="architecture fragment fade-out" data-fragment-index="1"
         data-src="images/standard-architecture.svg" />

    <span class="fragment" data-fragment-index="1">
        <img alt="mistral architecture"
             class="mistral architecture fragment fade-out" data-fragment-index="2"
             data-src="images/mistral-architecture.svg" />
    </span>

    <span class="fragment" data-fragment-index="2">
        <img alt="mistral failure domains"
             class="mistral architecture"
             data-src="images/mistral-failure-domains.svg" />
    </span>
</div>


<!-- .slide: data-state="normal" id="mistral-summary" data-menu-title="Mistral summary" data-timing="40"-->
## Mistral-based resurrection workflow

*   https://github.com/gryf/mistral-evacuate

### Pros

*   In line with upstream OpenStack strategy
*   Clean, simple approach
*   Potential for integration with Congress for policy-based workflows

### Cons

*   Still experimental code; not yet usable by most
*   Mistral resilience WIP

Note:
Reuses components rather than adding yet another project
We can make different decision based on failure type using congress
Marking vms as pets
Describe problem with mistral HA


<!-- .slide: data-state="normal" id="mistral-workflow" data-menu-title="Mistral workflow" data-timing="30"-->
## Evacuate workflow
<img alt="Evacuate Workflow"
     src="images/workflow.svg" />

Note:
Whole workflow should start with nova mark-host-down if fencing was before
repeat is not forever


<!-- .slide: data-state="normal" id="mistral-mark-vms" data-menu-title="Mistral mark VMS" data-timing="20"-->
## Marking VMs as pets
```
$ nova meta very_important_VM set evacuate=true
$ nova flavor-key very_important_flavor set evacuation:evacuate=true
```

Note:
Two ways of marking vms
Prefix in flaovor is important; without it if we try to schedule vm with 'very important flavor' nova-scheduler would try to find agregate with 'evacuate' capability - as a result vm will end up in error state


<!-- .slide: data-state="normal" id="senlin" data-timing="60"-->
# Senlin

*   https://wiki.openstack.org/wiki/Senlin
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
      <td class="yes">Yes</td>
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

