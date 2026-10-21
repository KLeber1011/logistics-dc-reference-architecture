# Logistics Condominium — Shared Technology Infrastructure
### A multi-tenant reference architecture

> **Reference architecture / design exercise.** Greenfield study, not a client
> deliverable. Modeled on the **public profile** of the Greater São Paulo logistics
> corridor (Guarulhos / Marginal Tietê) as a realistic sizing reference. No internal
> data, topology or confidential information from any company is used. Figures are
> illustrative.

---

## The one-paragraph version

A logistics-condominium developer wants to lease modules **faster and at better rent**
by delivering them technology-ready — because the modern warehouse runs WMS,
automation, dense Wi-Fi, IoT and CCTV, and *an IT outage is a production outage*. This
architecture designs the **shared infrastructure layer** the landlord owns — neutral
entrance and meet-me, optical backbone with spare capacity, Tier III-inspired critical
power, common-area systems, shared observability and an optional cloud on-ramp — and
draws the **written boundary** between what the landlord delivers and what each tenant
builds. It is written from the chair of the **integrator's solutions architect** who
converts commercial intent into a defensible technical specification and defends it to
a C-level.

---

## Why this scenario is real

Greater São Paulo logistics real estate is in an expansion cycle: the state holds on
the order of 19.5 million m² of stock, with millions of m² more scheduled nationally
through 2026, and the Guarulhos / Marginal Tietê corridor is its densest node.
Technology-readiness has become a **leasing differentiator**, not a nice-to-have — and
logistics condominiums are emerging as a new demand vertical for **dedicated IT,
critical power and cloud on-ramp at megaproject scale**, delivered as shared
infrastructure. Full context in [`01-DISCOVERY.md`](01-DISCOVERY.md) §2.

---

## How to read this repository

Executive layer here; depth in the linked artifacts.

| # | Artifact | What it answers |
|---|---|---|
| 01 | [Discovery](01-DISCOVERY.md) | Market, intent, need, stakeholders, drivers, requirements |
| 02 | [HLD](02-HLD.md) | The shared-infrastructure design and the convergence model |
| 03 | [Tenant Interface Spec](03-TENANT-INTERFACE-SPEC.md) | The landlord↔tenant boundary contract — the case's signature |
| 04 | [BoM / BoQ](04-BOM-BOQ.md) | Vendor-neutral components, quantities and service effort (LOE) |
| 05 | [TCO / ROI](05-TCO-ROI.md) | The business case, in scenarios |
| 06 | [Cloud Connect](06-CLOUD-CONNECT.md) | Hybrid on-ramp, corrected (DX/VPN→VGW; private access via endpoint) |
| 07 | [Technical Proposal](07-TECHNICAL-PROPOSAL.md) | The C-level executive summary |
| 08 | [Site Survey](08-SITE-SURVEY.md) | What must be verified before commitment |
| 09 | [Roadmap](09-ROADMAP.md) | Phasing and dependencies |
| 10 | [Risks](10-RISKS.md) | Register, with probability-vs-impact strategy |
| — | Decisions (ADRs) | [ADR-0001](ADR-0001-shared-neutral-layer.md) · [ADR-0002](ADR-0002-boundary-before-fitout.md) · [ADR-0003](ADR-0003-tier3-inspired-not-certified.md) · [ADR-0004](ADR-0004-ot-it-segregation.md) — the reasoning behind the four load-bearing choices |
| — | Governance | [RACI](RACI.md) · [SOW](SOW.md) — stakeholders, responsibilities, conceptual scope of work |
| — | Diagrams | [Topology](topology.md) — topology and hybrid-cloud path (Mermaid) |
| — | Lab | [AWS evidence](aws-evidence.md) · [Terraform](main.tf) — the buildable slice |

---

## What this case demonstrates

- **Scoping like an architect:** designing the shared layer the landlord owns, and
  bounding it against tenant scope with a written interface — the difference between a
  condominium and a warehouse.
- **The two languages the pre-sales architect role needs:** technical (backbone,
  Tier III-inspired power, OT/IT segregation, corrected hybrid cloud path) and
  financial (CAPEX/OPEX, TCO, ROI defended as scenarios).
- **Honesty as a seniority signal:** Tier III-*inspired*, not certified; diverse
  carrier route surveyed, not assumed; part of last-mile/grid risk managed, not
  eliminated.
- **Deploy-as-evidence:** the cloud decisions are real Terraform and a buildable AWS
  slice, not only diagrams — answering *"did you build it, or just draw it?"*

---

## Companion case

This is the enterprise/real-estate counterpart to the retail
[`sdwan-retail-reference-architecture`](https://github.com/KLeber1011/sdwan-retail-reference-architecture)
— same architectural discipline (HLD, ADRs, governance, honest risk), different
problem class (single-site density and a landlord↔tenant boundary, rather than
multi-site connectivity).

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
