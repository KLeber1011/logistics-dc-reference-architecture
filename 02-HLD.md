# 02 — High-Level Design (HLD)
## Multi-Tenant Logistics Condominium — Shared Technology Infrastructure

> **Reference architecture / design exercise.** Greenfield study, not a client
> deliverable. Modeled on the public profile of the Greater São Paulo logistics
> market. No confidential or client data. Figures illustrative.

**Scope of this HLD:** the **shared** technology infrastructure owned and delivered by
the condominium developer. Tenant internal networks are **not designed here** — they
appear as interface requirements, specified in
[`03-TENANT-INTERFACE-SPEC.md`](03-TENANT-INTERFACE-SPEC.md). Drivers, stakeholders
and requirements are established in [`01-DISCOVERY.md`](01-DISCOVERY.md).

---

## 1. Design principles

1. **Neutrality is the product.** No carrier and no tenant is structurally advantaged.
   Every capability is offered on equal terms.
2. **Capable and passive at the boundary.** The landlord delivers physical capacity
   and controlled shared services; the tenant owns its logical network.
3. **Headroom is bought at fit-out, never retrofitted.** Fibre count, containment,
   rack units and electrical capacity are provisioned once, while civil works are
   open.
4. **Availability is capped by the weakest of connectivity and power.** Both are
   engineered together for the technical core.
5. **What is shared is monitored.** Anything the landlord owns is instrumented and
   visible, because the landlord will be called when it fails.
6. **Every module is an instance of a template**, so growth is onboarding, not
   redesign.

---

## 2. Physical architecture — the convergence model

All external connectivity converges at a **single, shared entrance facility and
meet-me point**. Carrier circuits and tenant WAN services are **not on opposite
sides** of the design: the carrier terminates at the meet-me, and the tenant's own
edge equipment — sitting in its module technical room — is reached over the
condominium backbone. The tenant's WAN border is **logical** (where its routing and
policy live); the delivery point is **physical and shared**.

```
        CARRIER A ────┐                    ┌──── CARRIER B (where viable)
                      │                    │
                 ┌────┴────────────────────┴────┐
                 │   ENTRANCE FACILITY /         │
                 │   MEET-ME ROOM  (landlord)    │
                 │   • carrier demarcation       │
                 │   • cross-connect frame       │
                 │   • neutral, any carrier      │
                 └───────────┬──────────────────┘
                             │
                 ┌───────────┴──────────────────┐
                 │   SHARED TECHNICAL BUILDING   │
                 │   • condominium core switching│
                 │   • UPS + generator           │
                 │   • shared services & NOC feed│
                 │   • condominium observability │
                 └───────────┬──────────────────┘
                             │  optical backbone — spare fibre per module
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────┴─────┐        ┌─────┴────┐         ┌─────┴────┐
   │ MODULE 1 │        │ MODULE 2 │         │ MODULE n │
   │  IDF /   │        │  IDF /   │         │  IDF /   │
   │ tenant   │        │ tenant   │         │ tenant   │
   │ tech room│        │ tech room│         │ tech room│
   └──────────┘        └──────────┘         └──────────┘
        ▲
        └── everything beyond this point is TENANT scope
            (tenant edge/router, distribution, APs, OT, WMS)
            → specified as interface, not designed here
```

**Reading the model:** the tenant's cross-connect runs from its IDF, over the
landlord backbone, to the meet-me frame, where its chosen carrier terminates. The
landlord never routes tenant traffic; it provides the path and the frame.

---

## 3. Layers of the shared infrastructure

### 3.1 Entrance facility and meet-me
- Physically protected room with carrier demarcation and a neutral cross-connect
  frame.
- Provision for **two entrance paths**. A second, physically diverse route is a
  survey outcome, not an assumption — where unavailable off the shelf, it becomes a
  special project with its own cost and lead time (`08-SITE-SURVEY.md`).
- Access procedure for carrier technicians without exposing tenant areas.

### 3.2 Optical backbone
- Single-mode optical distribution from the technical building to each module IDF.
- **Spare fibre per module** dimensioned for future tenants, subdivision of a module,
  and future phases — the classic decision that is cheap now and painful later.
- Physically separated primary and secondary pathways where the civil design allows.

### 3.3 Shared technical building
- Condominium core switching for shared services.
- Landlord-owned services: common-area CCTV, access control, environmental and
  energy IoT, observability collectors.
- Critical power (section 4) and cooling.
- Space allocated for the shared cloud on-ramp (section 6), where offered.

### 3.4 Module technical space (the boundary object)
- A dedicated, lockable space per module with a defined allocation of **rack units,
  power draw and cooling**, which the tenant occupies with its own equipment.
- Landlord delivers: space, power, cooling, backbone termination, containment entry.
- Tenant delivers: its edge router, distribution switching, APs, NVR, OT uplinks.
- The allocation is contractual, not best-effort — see
  [`03-TENANT-INTERFACE-SPEC.md`](03-TENANT-INTERFACE-SPEC.md).

### 3.5 Pathways and containment
- Risers, trays and conduits sized with declared spare capacity.
- **Separated containment** for power, IT and OT/industrial runs, so tenants can
  build determinism-sensitive networks without EMI conflicts.
- Rooftop and wall provisions for tenant antennas, with defined rights and load.

---

## 4. Power — engineered as domains

| Domain | Serves | Posture |
|---|---|---|
| **Critical technical** | Meet-me, technical building core, module IDFs, shared CCTV/NVR | UPS + generator; **Tier III-inspired** concurrent maintainability and N+1 |
| **Facility** | Ventilation, common lighting, docks | Standard, with technical-area exceptions |
| **Tenant process** | Automation, conveyors, drives | Capacity and headroom provisioned; specification owned by tenant/vendor |
| **Administrative** | Offices | Standard |

Grounding and surge protection are specified explicitly. Availability targets for the
shared layer are only meaningful when the critical technical domain is protected and
tested — an acceptance criterion, not a statement of intent.

> **On Tier III:** this is a *design posture* — concurrent maintainability, N+1 on
> critical elements — inspired by data-centre practice. It is **not** a claim of
> Uptime Institute certification, which applies to data centres, not logistics
> facilities.

---

## 5. Common-area systems and shared observability

- **Perimeter and common-area IP CCTV** on its own segment, with dedicated storage
  and bandwidth ceilings, so it can never contend with anything else.
- **Access control** for gates, technical rooms and shared areas.
- **Shared IoT** for energy metering, environmental monitoring of technical rooms,
  and common-area telemetry.
- **Condominium observability**: link and path health at the meet-me and backbone,
  power and environmental status of technical areas, and capacity consumption per
  module. The landlord monitors **what the landlord owns** — it does not observe
  tenant traffic, which is both a privacy and a liability boundary.

---

## 6. Shared cloud on-ramp (optional service)

Offered as a shared capability that a tenant may consume or bypass entirely
(neutrality principle). Detailed in [`06-CLOUD-CONNECT.md`](06-CLOUD-CONNECT.md).

**The hybrid path, stated correctly:**

```
tenant edge (private IP, e.g. 10.20.0.1)
   → condominium backbone → meet-me cross-connect
   → carrier / colocation
   → Direct Connect  (private circuit)   ─┐
     or Site-to-Site VPN (IPsec)          ├→ Virtual Private Gateway / Transit Gateway
                                          ┘        → VPC
```

Two clarifications that matter, because they are commonly confused:

- **Direct Connect and VPN terminate on a Virtual Private Gateway or Transit
  Gateway — never on an Internet Gateway.** An Internet Gateway serves *public*
  traffic for public subnets and plays no part in the hybrid path.
- A private subnet reaches AWS services **without** internet egress via **VPC
  Endpoints** (Gateway endpoints for S3/DynamoDB; Interface endpoints/PrivateLink for
  the rest) — the mechanism that lets an isolated segment consume a managed service
  with no IGW and no NAT.

---

## 7. Capacity provisioning (illustrative template per module)

| Item | Provisioned | Rationale |
|---|---|---|
| Backbone fibre to module | Working pairs + declared spare | Future tenant, module subdivision, second carrier |
| Module technical space | Defined rack units | Tenant edge, distribution, NVR, OT uplink |
| Power to module technical space | Defined kVA on critical domain | Tenant IT load with headroom |
| Containment entry | Separate IT and OT entries | Determinism and EMI separation |
| Rooftop / wall antenna rights | Defined positions and load | Tenant Wi-Fi and wireless backup |
| Meet-me cross-connect | Defined port allocation | Tenant's own carrier choice |

Quantities are set in [`04-BOM-BOQ.md`](04-BOM-BOQ.md) and costed in
[`05-TCO-ROI.md`](05-TCO-ROI.md).

---

## 8. What is explicitly *not* designed here

Tenant Wi-Fi design and AP placement · tenant OT networks (Profinet/Profibus) ·
low-power IoT mesh and RFID deployment · tenant CCTV and WMS · automation equipment.

These are **interface requirements**: the shared layer must supply the pathways,
power, space, spectrum coordination and antenna rights they depend on. They are
enumerated, with the capacity each one drives, in
[`03-TENANT-INTERFACE-SPEC.md`](03-TENANT-INTERFACE-SPEC.md).

---

## 9. Acceptance criteria (shared layer)

- Meet-me supports more than one carrier, with tenant cross-connects delivered and
  documented.
- Backbone continuity and spare fibre count verified per module against the
  provisioning template.
- Critical power tested end to end, including transfer to generator where present;
  autonomy meets the stated posture.
- Tenant-to-tenant isolation verified on shared elements.
- Common-area CCTV proven not to contend with other shared traffic under load.
- Module technical space delivered with the contracted rack units, power and cooling,
  and formally accepted by the tenant against the interface spec.
- Shared-layer telemetry visible in condominium observability.

---

## 10. Related artifacts

`01-DISCOVERY` · `03-TENANT-INTERFACE-SPEC` · `04-BOM-BOQ` · `05-TCO-ROI` ·
`06-CLOUD-CONNECT` · `07-TECHNICAL-PROPOSAL` · `08-SITE-SURVEY` · `09-ROADMAP` ·
`10-RISKS` · `decisions/` · `governance/`

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
