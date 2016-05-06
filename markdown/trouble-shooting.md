<!-- .slide: data-state="section-break" id="trouble-shooting" -->
# Trouble-shooting


<!-- .slide: data-state="normal" id="verifying-node-failure-detection" -->
## Verifying compute node failure detection

Pacemaker monitors compute nodes via `pacemaker_remote`.

If compute node failure detected:

1.  compute node is fenced
    -   `crm_mon` etc. will show node unclean / offline
1.  Pacemaker invokes `fence-nova` as secondary fencing resource
    -   `crm resource show fence-nova`
    -   `/var/log/messages` on DC and node running `fence-nova`


<!-- .slide: data-state="normal" id="verifying-fence-nova" -->
## Verifying secondary fencing resource

`fence-nova` runs `fence_compute` script:

1.  tells `nova` server that node is down
1.  updates attribute on compute node to indicate node needs recovery;

Verify attribute state via:

```sh
attrd_updater --query --all --name=evacuate
```


<!-- .slide: data-state="normal" id="verifying-node-recovery" -->
## Verifying compute node failure recovery process

1.  `NovaEvacuate` spots attribute and calls `nova evacuate`
1.  `nova` resurrects VM on other node
