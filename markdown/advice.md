<!-- .slide: data-state="section-break" id="advice" -->
# Which one should I pick?

Note: this advice is intended to be as impartial as possible, based
on pure facts!

<!-- .slide: data-state="normal" id="decision-tree" -->
## Decision tree

<img alt="decision" src="images/decision-tree.svg"
     class="full-slide" />


<!-- .slide: data-state="normal" id="questions-to-ask-1" -->
# Questions to ask

Do you need a *vendor-supported, enterprise-ready* solution for production
clouds *right now*?

*   Private cloud?  Only current options:
    -   [RHEL OpenStack Platform](https://access.redhat.com/products/red-hat-enterprise-linux-openstack-platform/)
    -   [SUSE OpenStack Cloud](http://suse.com/cloud)
    -   Both based on OCF RA approach
    -   (**TODO**: check with Mirantis and Canonical)
*   Public cloud?
    -   ZeroStack hosted solution


<!-- .slide: data-state="normal" id="questions-to-ask-2" -->
# Questions to ask (2)

Are you prepared to support the solution yourself, and invest some
engineering effort on integration / DevOps?

**Recommendation: `masakari`**

*   Handles more failure cases than `OCF RA` approach
*   Fairly well tested and documented


<!-- .slide: data-state="normal" id="questions-to-ask-3" -->
# Questions to ask (3)

Are you interested in collaborating on experimental technology?

*   `mistral`
    *   One of the most promising approaches for the future
*   `senlin`


<!-- .slide: data-state="normal" id="questions-to-ask-4" -->
# Questions to ask (4)

Do you work for AWcloud or China Mobile?

-    Use your own solution ;-)
