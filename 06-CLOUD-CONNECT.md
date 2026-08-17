# 06 — Cloud Connect
## Hybrid on-ramp as a shared, neutral service

> **Reference architecture / design exercise.** The shared cloud on-ramp a tenant may
> consume or bypass (neutrality principle). Cloud services are named by **category**;
> an AWS instantiation is given as a concrete example, not a lock-in. Companion to
> [`02-HLD.md`](02-HLD.md) §6 and to the lab evidence in [`lab/`](lab/).

---

## 1. What this is, and what it is not

The condominium offers a **shared path to cloud** — a meet-me aggregation point where
a tenant can reach a cloud provider over a private circuit or a VPN, instead of each
tenant building its own. A tenant is free to ignore it and bring its own connectivity;
neutrality is preserved.

This artifact does **not** design the tenant's cloud architecture. It designs the
*on-ramp* — the connectivity and the boundary — and shows, as an example, how a tenant
workload would land in a VPC.

---

## 2. The hybrid path — stated correctly

This is where terminology is commonly wrong, so it is stated precisely:

```
tenant edge (private IP, e.g. 10.20.0.1)
   │
   ├─ condominium backbone → meet-me cross-connect → carrier / colocation
   │
   ├─ Direct Connect (private circuit)  ─┐
   │                                     ├──► Virtual Private Gateway (VGW)
   └─ Site-to-Site VPN (IPsec/internet) ─┘     or Transit Gateway (TGW)
                                                     │
                                                     ▼
                                                  VPC (tenant)
```

**Two clarifications that a reviewer will check:**

- **Direct Connect and Site-to-Site VPN terminate on a Virtual Private Gateway or a
  Transit Gateway — never on an Internet Gateway.** An Internet Gateway serves
  *public* subnet traffic and plays no part in the hybrid path. Confusing the two is
  the classic tell of someone who has not built it.
- A **private subnet reaches AWS services without any internet path** via **VPC
  Endpoints**: a **Gateway Endpoint** for S3 and DynamoDB (no cost), an **Interface
  Endpoint / PrivateLink** for the rest. This is the mechanism that lets an isolated
  segment — including an OT-adjacent one — consume a managed service with **no IGW and
  no NAT**.

---

## 3. Reference landing zone (example, multi-tenant)

The example that the lab instantiates:

```
   VPC-SERVICES (shared) ── VPC Peering ── VPC-TENANT-A
                        └─── VPC Peering ── VPC-TENANT-B
   (peering is non-transitive: A and B cannot reach each other → tenant isolation)

   VPC-TENANT-A
     ├─ subnet: edge/public      → IGW  (only where public egress is required)
     ├─ subnet: it-corp/private  → workloads that tolerate cloud
     └─ subnet: ot-isolated      → NO internet route
                                    reaches S3 via Gateway VPC Endpoint only
```

The **non-transitive peering** is the cloud-side expression of the same rule as the
physical design: tenants share infrastructure but never reach each other. The
**endpoint-only OT subnet** is the ADR on OT/IT segregation, turned into
configuration.

---

## 4. Workload → capability → service → outcome

The mapping the design promises, one level below "cloud" (answering the earlier gap:
name the service and the expected result), vendor example in brackets:

| Workload | Capability | Example service (AWS) | Expected outcome |
|---|---|---|---|
| WMS execution | On-site low-latency compute | *(edge, not cloud)* | Picking survives a WAN outage; syncs on recovery |
| WMS sync edge→cloud | Durable messaging | SQS / MSK | No lost transactions across the link |
| WMS analytics / KPIs | Data warehouse | Redshift / Athena+S3 | Picking metrics without touching execution |
| ERP / corporate | Managed compute + DB | EC2/EKS + RDS | Central, elastic, patched by platform |
| CCTV archive | Object storage + lifecycle | S3 + Glacier | Long retention at low cost |
| IoT telemetry | Ingest + time-series | IoT Core + Timestream | Energy/environment trends |
| Private access to a service | Private endpoint | **VPC Gateway Endpoint** | Isolated subnet reaches S3 with **no IGW/NAT** |
| Observability | Metrics + logs + flow | CloudWatch + VPC Flow Logs | Single view; feeds the elasticity trigger |
| Seasonal scale | Elastic compute | Auto Scaling / managed services | Pay for the peak only at peak |

**Elasticity caveat (carried from the retail case):** elasticity scales *cloud-side*
capacity. It does nothing for a site whose link or power is down at peak — and peak
(e-commerce season) is when they are most stressed. Edge resilience and cloud
elasticity must be dimensioned to the **same** peak.

---

## 5. What is lab-proven vs conceptual

Honesty about what was actually built (see [`lab/aws-evidence.md`](lab/aws-evidence.md)):

| Element | Status | Why |
|---|---|---|
| VPC, subnets, route tables, security groups | **Built (free tier)** | Segmentation foundation |
| Multi-VPC + non-transitive peering | **Built (free)** | Tenant isolation proven |
| Gateway VPC Endpoint (S3) on isolated subnet | **Built (free)** | OT/IT private-access proven, no IGW/NAT |
| S3 bucket as CCTV/IoT sink + lifecycle | **Built (free tier)** | "Something is actually deployed" |
| VPC Flow Logs → S3 | **Built (low cost)** | Observability layer |
| Direct Connect / Transit Gateway / VPN | **Conceptual** | Real circuits/TGW cost money; peering simulates the enlace at zero cost |
| Redshift / Interface Endpoints | **Conceptual** | Documented with rationale; not lab-built |

Building a *representative slice* and being explicit about what is conceptual is what
an architect does — versus pretending the whole thing was deployed.

---

## 6. Infrastructure as Code

The buildable slice is provisioned as **Terraform**, versioned in [`lab/`](lab/), so
the landing zone is reproducible and reviewable — evidence of "automação de
infraestrutura e orquestração" (a Logicalis requirement) and of *deploy-as-evidence*
rather than screenshots alone.

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; AWS named as example, not endorsement; contains
no confidential or client data.*
