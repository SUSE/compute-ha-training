<!-- .slide: data-state="section-break" id="when" data-menu-title="Why compute HA?" -->
# When is compute HA important?


<!-- .slide: data-state="normal" id="pets-vs-cattle" class="pets-vs-cattle" -->
## Pets vs. cattle

<div class="row pets">
    <div class="col-md-5">
        <img src="images/begging-cat-c2.jpg" alt="cute pleading cat"
             class="pull-right" />
    </div>
    <div class="col-md-7">
        <ul>
            <li class="fragment" data-fragment-index="2">
                Pets are given names like <tt>mittens.mycompany.com</tt>
            <li class="fragment" data-fragment-index="3">
                Each one is unique, lovingly hand-raised and cared for
            <li class="fragment" data-fragment-index="4">
                When they get ill, you spend money nursing them back to health
        </ul>
    </div>
</div>

<div class="row cattle">
    <div class="col-md-5">
        <img src="images/cattle-c.jpg" alt="cattle" class="pull-right" />
    </div>
    <div class="col-md-7" style="height: 100%">
        <ul class="vcenter">
            <li class="fragment" data-fragment-index="2">
                Cattle are given names like <tt>vm0213.cloud.mycompany.com</tt>
            <li class="fragment" data-fragment-index="3">
                They are almost identical to other cattle
            <li class="fragment" data-fragment-index="4">
                When one gets ill, you shoot it and get another one
        </ul>
    </div>
</div>


<!-- .slide: data-state="normal" id="pets-vs-cattle-2" class="pets-vs-cattle" data-menu-title="Dead VMs" -->
## What does that mean in practice?

<div class="row pets">
    <div class="col-md-5">
        <img src="images/begging-cat-c2.jpg" alt="cute pleading cat"
             class="pull-right" />
    </div>
    <div class="col-md-7 vcenter">
        <ul>
            <li class="fragment" data-fragment-index="1">
                Service downtime when a pet dies
            <li class="fragment" data-fragment-index="2">
                VM instances often stateful, with mission-critical data
            <li class="fragment" data-fragment-index="3">
                <span class="fg-bright-orange">Needs automated recovery
                with data protection</span>
        </ul>
    </div>
</div>

<div class="row cattle">
    <div class="col-md-5">
        <img src="images/cattle-c.jpg" alt="cattle" class="pull-right" />
    </div>
    <div class="col-md-7" style="height: 100%">
        <ul class="vcenter">
            <li class="fragment" data-fragment-index="1">
                Service resilient to instances dying
            <li class="fragment" data-fragment-index="2">
                Stateless, or ephemeral (disposable) storage
            <li class="fragment" data-fragment-index="3">
                <span class="fg-medium-green">Already ideal for cloud</span>
                <span class="fg-bright-orange">… but can still benefit
                from automated recovery!</span>
        </ul>
    </div>
</div>


<!-- .slide: data-state="normal" id="compute-failure" data-menu-title="Compute failure" -->
## If only the control plane is HA …

<img class="arch" alt="control/compute architecture" src="images/architecture.svg" />
<img class="fragment bang" alt="compute node explosion!" src="images/explosion.svg" />


<!-- .slide: data-state="normal" id="cattle-dead" data-menu-title="Dead cattle" -->
## If compute node is hosting cattle …

<img class="cattle" src="images/cattle-c.jpg" alt="cattle" />
<img class="fragment bang" alt="cow explosion!" src="images/explosion.svg"
     data-fragment-index="1" />

automatically <!-- .element: class="fragment" data-fragment-index="1" -->
resurrect via OpenStack Orchestration (Heat) *convergence* feature <br />
[(in theory?)](https://wiki.openstack.org/wiki/Heat/HA)

Note: http://docs.openstack.org/developer/heat/ says "templates […]
allow some more advanced functionality such as instance high
availability […]"

... but wiki hopelessly out of date, and HARestarter deprecated since Kilo
in favour of convergence - see http://specs.openstack.org/openstack/heat-specs/


<!-- .slide: data-state="normal" id="kittehs-dead" data-menu-title="Dead pets" -->
## If compute node is hosting pets …

<img class="pets" src="images/cats.jpg" alt="pets" />
<img class="fragment bang" alt="kitty explosion!" src="images/explosion.svg"
     data-fragment-index="1" />

We <!-- .element: class="fragment" data-fragment-index="1" -->
have to resurrect <span class="fg-bright-red">very carefully in order to
avoid any zombie pets</span>
