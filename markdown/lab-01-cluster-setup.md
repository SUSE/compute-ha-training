<!-- .slide: data-state="section-break" id="lab-1" data-menu-title="Lab 1: cluster setup" -->
# Lab 1: add remotes to Pacemaker cluster


<!-- .slide: data-state="normal" id="starting-point" data-menu-title="Starting point" -->
## Starting point

* 2 controllers in HA cluster
* 3 compute nodes
* All barclamps deployed!



<!-- .slide: data-state="normal" id="pacemaker-bc-roles" data-menu-title="Barclamp roles" -->
## Pacemaker barclamp clusters, nodes, and roles

<img class="full-slide" alt="Screenshot of Pacemaker barclamp clusters, nodes, and roles"
     data-src="images/hands-on/09-pacemaker-deployment-1.png" />

Note:
First delete any existing role assignments by clicking `Remove all`.


<!-- .slide: data-state="normal" id="pacemaker-role-assignment" data-menu-title="Role assignment" -->
## Pacemaker role assignment

<img class="full-slide" alt="Screenshot of Pacemaker barclamp role assignment"
     data-src="images/hands-on/10-pacemaker-deployment-2.png" />


<!-- .slide: data-state="normal" id="pacemaker-apply" data-menu-title="Apply" -->
## Apply Pacemaker proposal

<img class="full-slide" alt="Screenshot of Pacemaker barclamp apply"
     data-src="images/hands-on/12-pacemaker-apply.png" />


<!-- .slide: data-state="normal" id="crm-nodes-status" data-menu-title="Check progress" -->
## Check progress of proposal

<br />
```sh
root@crowbar:~ # tail -f /var/log/crowbar/production.log
root@crowbar:~ # tail -f /var/log/crowbar/chef-client/*.log
```


<!-- .slide: data-state="normal" id="crm-nodes-status" data-menu-title="Check nodes status" -->
## Check status of cluster nodes and remotes

Login to one of the controller nodes, and do:

<img class="full-slide" alt="Screenshot of running crm status"
     data-src="images/hands-on/30-crm-status-1.png" />

<img class="full-slide" alt="Screenshot of stonith/remote resources"
     data-src="images/hands-on/31-crm-status-2.png" />
