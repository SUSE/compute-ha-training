<!-- .slide: data-state="section-break" id="terminology" -->
# Brief interlude: `nova evacuate`


<!-- .slide: data-state="normal" id="evacuate-architecture" data-menu-title="nova's recovery API" class="architecture" -->
## `nova`'s recovery API

<div class="architecture">
    <img alt="Architecture with pacemaker_remote"
         class="architecture"
         src="images/standard-architecture.svg" />

    <img alt="Architecture use of evacuate API"
         class="evacuate-api-arrow fragment"
         src="images/standard-architecture-evacuate-API-arrow.svg" />
</div>


<!-- .slide: data-state="normal" id="nova-evacuate" -->
## `nova evacuate`

*   API provided by `nova` for initiating recovery of VM
*   http://docs.openstack.org/admin-guide/cli_nova_evacuate.html

```sh
# nova help evacuate
usage: nova evacuate [--password <password>] [--on-shared-storage]
                     <server> [<host>]

Evacuate server from failed host.
```

*   Used by most HA solutions
*   Without shared storage, simply rebuilds from scratch


<!-- .slide: data-state="normal" id="public-health-warning" -->
## Public Health Warning

### `nova evacuate` does not really mean evacuation!

<img alt="skull and cross-bones warning triangle"
     src="images/hazardous.gif" />


<!-- .slide: data-state="normal" id="hurricanes" class="hurricane" -->
## Think about natural disasters

<div class="row vcenter before">
    <div class="col-md-6">
        <img src="images/hurricane-Andrew.jpg" alt="hurricane Andrew satellite view"
             class="pull-right" />
    </div>
    <div class="text col-md-6">
        <h3 class="fragment" data-fragment-index="1">
            Not too late to evacuate
        </h3>
    </div>
</div>
<br clear="left" />
<div class="row vcenter after">
    <div class="col-md-6">
        <img src="images/hurricane-devastation.jpg" alt="hurricane devastation"
             class="pull-right" />
    </div>
    <div class="text col-md-6">
        <h3 class="fragment" data-fragment-index="1">
            Too late to evacuate
        </h3>
    </div>
</div>


<!-- .slide: data-state="normal" id="nova-terminology" class="hurricane" -->
## `nova` terminology

<div class="row vcenter before">
    <div class="col-md-6">
        <img src="images/hurricane-Andrew.jpg" alt="hurricane Andrew satellite view"
             class="pull-right" />
    </div>
    <div class="text col-md-6">
        <h3>
            `nova live-migration`
        </h3>
    </div>
</div>
<br clear="left" />
<div class="row vcenter after">
    <div class="col-md-6">
        <img src="images/hurricane-devastation.jpg" alt="hurricane devastation"
             class="pull-right" />
    </div>
    <div class="text col-md-6">
        <h3>
            `nova evacuate` <span class="fg-bright-orange bold">?!</span>
        </h3>
    </div>
</div>


<!-- .slide: data-state="normal" id="health-warning-summary" -->
# Public Health Warning

*   `nova evacuate` does *not* do evacuation
*   `nova evacuate` does resurrection (after releasing dependencies)
*   In Vancouver, `nova` developers considered a rename
    *    Hasn't happened yet
    *    Due to impact, seems unlikely to happen any time soon

<h2 class="fg-dark-green" style="margin-top: 50px;">
    Whenever you see “*evacuate*” in a `nova`-related context,
    pretend you saw “*resurrect*”
</h2>
