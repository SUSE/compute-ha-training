<!-- .slide: data-state="section-break" id="HA-today" data-timing="5" -->
# HA in OpenStack today


<!-- .slide: data-state="normal" id="control-plane" class="diagram-and-list" data-timing="20" -->
## Typical HA control plane

<div class="diagrams">
    <img class="services" data-src="images/services-cluster.svg"
         alt="HA services cluster" />
    <img class="db-mq" data-src="images/DB-MQ-cluster.svg"
         alt="database and message queue cluster" />
</div>

*   Automatic restart of controller services
*   Increases uptime of cloud

Note:
*   Active / active API services with load balancing
*   DB + MQ either active / active or active / passive


<!-- .slide: data-state="normal" id="controller-HA" class="diagram-and-list" data-timing="20" -->
# Under the covers

<div class="diagrams">
    <img class="cluster" data-src="images/HAProxy-Pacemaker.svg"
         alt="HAProxy fronting a Pacemaker cluster" />
</div>

*   Recommended by <!-- .element: style="margin-top: 100px;" -->
    official [HA&nbsp;guide](http://docs.openstack.org/ha-guide/)

<div class="solved stamp fragment">
    <p class="solved">SOLVED</p>
    <p class="mostly fragment">(mostly)</p>
</div>

Note:

- [HAProxy](http://www.haproxy.org/) distributes service requests
- [Pacemaker](http://clusterlabs.org/) monitors and controls nodes and services
- These days, to a large extent this is a solved problem!

[`neutron` HA is tricky](https://youtu.be/vBZgtHgSdOY), but out of the
scope of this talk.


<!-- .slide: data-state="normal" id="compute-failure" data-menu-title="Compute failure" data-timing="15" -->
## If only the control plane is HA …

<img class="arch" alt="control/compute architecture" data-src="images/architecture.svg" />
<img class="fragment bang" alt="compute node explosion!" data-src="images/explosion.svg" />

Note:
The control plane on the LHS is HA, but VMs live on the RHS,
so what happens if one of the compute nodes blows up?  That's
the topic of the rest of this talk!
