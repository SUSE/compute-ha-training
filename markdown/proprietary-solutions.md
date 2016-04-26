<!-- .slide: data-state="section-break" id="proprietary-solutions" -->
# Proprietary solutions


<!-- .slide: data-state="normal" id="awcloud-china-mobile" -->
# AWcloud / China Mobile

*   Very different solution
*   [Presented in Tokyo](https://youtu.be/nz4kEZcmxr4)
*   Uses Consul / raft / gossip instead of Pacemaker
*   Fencing via IPMI / self-fencing
*   Has some interesting capabilities
    *   gossip potentially more resilient than peer-to-peer
    *   action matrix: configurable per failure mode
*   Source code not available


<!-- .slide: data-state="normal" id="zerostack" -->
# ZeroStack

*   [Presented in Tokyo](https://youtu.be/F0P1ueq05a8)
*   Proprietary cloud-in-a-box
*   SaaS management portal
*   Adaptive, self-healing approach
*   Every node is dynamically (re-)assigned a role
*   Much harder to lose quorum, since non-voting nodes can
    be promoted to voting status

Note:
- Needs outgoing TCP port 443 for SaaS portal
- Node could switch from controller to compute based on demand
