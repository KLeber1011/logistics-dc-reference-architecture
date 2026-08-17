# ADR-0004 — OT and IT are segregated; crossings are explicit and endpoint-mediated

**Status:** Accepted

## Context
Automation (Profinet/Profibus) is deterministic and safety-relevant; general IT is not.
A flat adjacency between them lets IT traffic — or an IT compromise — disturb or reach
the process network. In the cloud landing zone, the same principle applies to isolated
subnets.

## Decision
OT is **physically and logically segregated** from IT. Any OT↔IT communication crosses
a **documented, controlled boundary** only. In cloud, the isolated (OT-adjacent) subnet
has **no internet route** and reaches services **only via a VPC Gateway Endpoint** — no
IGW, no NAT.

## Consequences
**Positive:** determinism and safety protected; blast radius contained; the boundary is
configuration, not a diagram.
**Trade-off:** OT↔IT integration (e.g. WMS→sorter) must be engineered deliberately at
the crossing, not assumed — which is correct.

## Notes
This ADR is the one that turns into real config in the lab (`lab/`), which is why it is
also the strongest interview artifact.
