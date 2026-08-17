# 10 — Risk Register

> **Reference architecture / design exercise.** Rated by impact and likelihood. The
> mitigation strategy distinguishes reducing *probability* from reducing *impact* —
> the same discipline as the retail case.

| # | Risk | Impact | Likelihood | Mitigation | Ref |
|---|---|---|---|---|---|
| R1 | No diverse carrier route off the shelf | High | Medium–High | Survey early; special project fired Phase 0; or accept & document | [08](08-SITE-SURVEY.md) |
| R2 | Power outage drops the critical domain | High | Medium | UPS N+1 + generator; grounding/surge; tested transfer | [02](02-HLD.md) §4 |
| R3 | Boundary undocumented → retrofit disputes | High | High (if unmanaged) | Interface spec signed before fit-out | [03](03-TENANT-INTERFACE-SPEC.md) |
| R4 | Spare capacity under-provisioned | High | Medium | Declared spare fibre/U/kVA at fit-out; cheap now, costly later | [04](04-BOM-BOQ.md) |
| R5 | Tenant-to-tenant leakage on shared elements | High | Low–Medium | Enforced isolation (physical + non-transitive peering) | [06](06-CLOUD-CONNECT.md) |
| R6 | OT/IT flat adjacency created inadvertently | High | Low | Documented crossing points only; endpoint-only isolated subnet | [06](06-CLOUD-CONNECT.md) |
| R7 | Grid quality worse than assumed | Medium | Medium | Survey outage history; size autonomy/protection accordingly | [08](08-SITE-SURVEY.md) |
| R8 | Long-lead external dependency slips | High | Medium | Surfaced in dependency matrix; fired Phase 0 | [09](09-ROADMAP.md) |
| R9 | Elastic cloud scales but tenant link/power down at peak | High | Medium | Dimension edge and cloud to the same peak | [06](06-CLOUD-CONNECT.md) |
| R10 | Ad-hoc growth erodes the template | Medium | Medium | Every module instantiates the standard template | [04](04-BOM-BOQ.md) |

## Residual-risk statement

Where a diverse carrier route is infeasible, part of R1 is **accepted and monitored**,
not eliminated — stated plainly rather than hidden. A design that promised universal
redundancy in every site would be the first thing an experienced reviewer disbelieves.

---
*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
