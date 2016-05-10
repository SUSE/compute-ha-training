<!-- .slide: data-state="section-break" id="trouble-shooting" -->
# Trouble-shooting


<!-- .slide: data-state="normal" id="verifying-node-failure-detection" data-menu-title="Failure detection" -->
## Verifying compute node failure detection

Pacemaker monitors compute nodes via `pacemaker_remote`.

If compute node failure detected:

1.  compute node is fenced
    -   `crm_mon` etc. will show node unclean / offline
1.  Pacemaker invokes `fence-nova` as secondary fencing resource
    ```sh
    crm configure show fencing_topology
    ```

Find node running `fence_compute`:

```sh
crm resource show fence-nova
```


<!-- .slide: data-state="normal" id="verifying-fence-nova" data-menu-title="Secondary fencing" -->
## Verifying secondary fencing

`fence_compute` script:

1.  tells `nova` server that node is down
1.  updates attribute on compute node to indicate node needs recovery

Log files:

-   `/var/log/nova/fence_compute.log`
-   `/var/log/messages` on DC and node running `fence-nova`

Verify attribute state via:

```sh
attrd_updater --query --all --name=evacuate
```


<!-- .slide: data-state="normal" id="verifying-node-recovery" data-menu-title="Recovery" -->
## Verifying compute node failure recovery process

1.  `NovaEvacuate` spots attribute and calls `nova evacuate`
    ```sh
    root@controller1:~ # crm resource show nova-evacuate
    resource nova-evacuate is running on: d52-54-77-77-77-02
    ```
1.  `nova` resurrects VM on other node
    ```sh
    root@controller2:~ # grep nova-evacuate /var/log/messages
    NovaEvacuate [...] Initiating evacuation
    NovaEvacuate [...] Completed evacuation
    ```


<!-- .slide: data-state="normal" id="process-failures" data-menu-title="Process failures" -->
## Process failures

`pacemaker_remote` looks after key compute node services.

*   Exercise: use `crmsh` on `cl-g-nova-compute` to find out
    which services it looks after
*   Try killing a process and see what happens
    - nothing, thanks to [bsc#901796](https://bugzilla.suse.com/show_bug.cgi?id=901796)
*   Try *stopping* a process and see what happens
*   Try breaking a process (e.g. corrupt config file and restart)
