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

*   Increases cloud uptime
*   Automatic restart of OpenStack controller services
*   Active / active API services with load balancing
*   DB + MQ either active / active or active / passive


<!-- .slide: data-state="normal" id="controller-HA" class="diagram-and-list" -->
# Under the covers

<div class="diagrams">
    <img class="cluster" src="images/HAProxy-Pacemaker.svg"
         alt="HAProxy fronting a Pacemaker cluster" />
</div>

*   Recommended by official [HA&nbsp;guide](http://docs.openstack.org/ha-guide/)
*   [HAProxy](http://www.haproxy.org/) distributes service requests
*   [Pacemaker](http://clusterlabs.org/)
    *   monitoring and control of nodes and services
*   Corosync
    *   cluster membership / messaging / quorum / leadership election

<br clear="left" />
## But what I really want to do is keep my workloads up! <!-- .element: class="fg-bright-red fragment" -->
