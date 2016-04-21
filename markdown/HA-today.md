<!-- .slide: data-state="section-break" id="HA-today" -->
# HA in OpenStack today


<!-- .slide: data-state="normal" id="control-plane" class="diagram-and-list" -->
# Typical HA control plane

<div class="diagrams">
    <img class="services" src="images/services-cluster.svg"
         alt="HA services cluster" />
    <img class="db-mq" src="images/DB-MQ-cluster.svg"
         alt="database and message queue cluster" />
</div>

*   Automatic restart of controller services
*   Increases uptime of cloud

Note:
*   Active / active API services with load balancing
*   DB + MQ either active / active or active / passive


<!-- .slide: data-state="normal" id="controller-HA" class="diagram-and-list" data-timing="40" -->
# Under the covers

<div class="diagrams">
    <img class="cluster" src="images/HAProxy-Pacemaker.svg"
         alt="HAProxy fronting a Pacemaker cluster" />
</div>

*   Recommended by <!-- .element: style="margin-top: 100px;" -->
    official [HA&nbsp;guide](http://docs.openstack.org/ha-guide/)
*   `neutron` poses [some challenges](https://youtu.be/vBZgtHgSdOY)!
*   `keepalived` / VRRP often used

<div class="solved stamp fragment">
    <p class="solved">SOLVED</p>
    <p class="mostly fragment">(mostly)</p>
</div>

Note:

- [HAProxy](http://www.haproxy.org/) distributes service requests
- [Pacemaker](http://clusterlabs.org/) monitors and controls nodes and services
- Corosync does cluster membership / messaging / quorum / leadership election
- neutron HA is very difficult, but out of the scope of this talk
- These days, to a large extent this is a solved problem!


<!-- .slide: data-state="normal" id="compute-failure" data-menu-title="Compute failure" -->
## If only the control plane is HA …

<img class="arch" alt="control/compute architecture" src="images/architecture.svg" />
<img class="fragment bang" alt="compute node explosion!" src="images/explosion.svg" />

Note:
The control plane on the LHS is HA, but VMs live on the RHS,
so what happens if one of the compute nodes blows up?  That's
the topic of the rest of this talk!
