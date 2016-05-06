<!-- .slide: data-state="section-break" id="lab-1" data-menu-title="Lab 1: cluster setup" -->
# Lab 1: setup Pacemaker cluster and remotes


<!-- .slide: data-state="normal" id="starting-point" data-menu-title="Starting point" -->
## Starting point

<img class="full-height" alt="Screenshot of lab starting point"
     data-src="images/hands-on/01-starting-point.png" />

Note:
We will consider all these barclamps already installed and nodes discovered and allocated


<!-- .slide: data-state="normal" id="pacemaker-proposal" data-menu-title="Proposal" -->
## Create Pacemaker proposal

<img class="full-slide" alt="Screenshot of creating Pacemaker proposal"
     data-src="images/hands-on/02-create-pacemaker-proposal.png" />


<!-- .slide: data-state="normal" id="pacemaker-stonith" data-menu-title="STONITH" -->
## STONITH options

<img class="full-slide" alt="Screenshot of Pacemaker barclamp STONITH options"
     data-src="images/hands-on/04-pacemaker-stonith.png" />


<!-- .slide: data-state="normal" id="pacemaker-drbd-1" data-menu-title="DRBD" -->
## DRBD option

<img class="full-slide" alt="Screenshot of Pacemaker barclamp DRBD option"
     data-src="images/hands-on/06-pacemaker-drbd-1.png" />

Note:
We can't set this until we have some nodes assigned to the cluster,
which we'll do soon.  Yes, this UI should be improved.


<!-- .slide: data-state="normal" id="pacemaker-bc-roles" data-menu-title="Barclamp roles" -->
## Pacemaker barclamp clusters, nodes, and roles

<img class="full-slide" alt="Screenshot of Pacemaker barclamp clusters, nodes, and roles"
     data-src="images/hands-on/09-pacemaker-deployment-1.png" />


<!-- .slide: data-state="normal" id="pacemaker-role-assignment" data-menu-title="Role assignment" -->
## Pacemaker role assignment

<img class="full-slide" alt="Screenshot of Pacemaker barclamp role assignment"
     data-src="images/hands-on/10-pacemaker-deployment-2.png" />


<!-- .slide: data-state="normal" id="pacemaker-drbd-2" data-menu-title="DRBD again" -->
## DRBD option revisited

<img class="full-slide" alt="Screenshot of Pacemaker barclamp DRBD option again"
     data-src="images/hands-on/11-pacemaker-drbd-2.png" />


<!-- .slide: data-state="normal" id="pacemaker-apply" data-menu-title="Apply" -->
## Apply Pacemaker proposal

<img class="full-slide" alt="Screenshot of Pacemaker barclamp apply"
     data-src="images/hands-on/12-pacemaker-apply.png" />


<!-- .slide: data-state="normal" id="pacemaker-attributes" data-menu-title="Attributes" -->
## Pacemaker attributes

<img class="full-slide" alt="Screenshot of Pacemaker barclamp attributes"
     data-src="images/hands-on/03-pacemaker-attributes.png" />


<!-- .slide: data-state="normal" id="pacemaker-mail" data-menu-title="Mail notifications" -->
## Mail notification options

<img class="full-slide" alt="Screenshot of Pacemaker barclamp mail notification options"
     data-src="images/hands-on/05-pacemaker-mail-notifications.png" />


<!-- .slide: data-state="normal" id="pacemaker-haproxy" data-menu-title="HAproxy" -->
## HAproxy option

<img class="full-slide" alt="Screenshot of Pacemaker barclamp HAproxy option"
     data-src="images/hands-on/07-pacemaker-haproxy.png" />


<!-- .slide: data-state="normal" id="pacemaker-hawk" data-menu-title="Hawk option" -->
## Hawk web UI option

<img class="full-slide" alt="Screenshot of Pacemaker barclamp Hawk web UI option"
     data-src="images/hands-on/08-pacemaker-hawk.png" />


<!-- .slide: data-state="normal" id="crm-nodes-status" data-menu-title="Check nodes status" -->
## Check status of cluster nodes and remotes

Login to one of the controller nodes, and do:

<img class="full-slide" alt="Screenshot of running crm status"
     data-src="images/hands-on/30-crm-status-1.png" />

<img class="full-slide" alt="Screenshot of stonith/remote resources"
     data-src="images/hands-on/31-crm-status-2.png" />
