# 04 — Bill of Materials (BoM) & Bill of Quantities (BoQ)
## Shared technology infrastructure — condominium scope

> **Reference architecture / design exercise.** Vendor-neutral, at the **capability**
> level — one step below "capability", never a product catalogue. A real project maps
> these to SKUs after a proof of concept and a chosen vendor. Quantities are
> illustrative, structured as a per-module template that scales across the park.
> Companion to [`02-HLD.md`](02-HLD.md) and [`03-TENANT-INTERFACE-SPEC.md`](03-TENANT-INTERFACE-SPEC.md).

---

## 1. How to read this

- **BoM** = *what* (the components and their capability spec).
- **BoQ** = *how much* (quantities, per module and per park phase).
- **LOE** = *effort* (services to design, deploy and validate — the "estimativa de
  esforço de serviços" the Logicalis role asks for).

Scope is the **shared** infrastructure only. Tenant-side equipment (APs, tenant
switches, NVR, OT) is out of scope and appears in `03` as interface, not here.

---

## 2. BoM — shared infrastructure components

### 2.1 Entrance facility & meet-me

| Item | Capability spec | Notes |
|---|---|---|
| Optical distribution frame (ODF) | High-density, neutral cross-connect | Any-carrier, any-tenant |
| Carrier demarcation panels | Per carrier | Provision for ≥2 carriers |
| Meet-me cross-connect | Managed patching | Tenant→carrier path |
| Physical security | Access-controlled room | Carrier tech access without tenant exposure |

### 2.2 Optical backbone

| Item | Capability spec | Notes |
|---|---|---|
| Single-mode fibre, technical building → module | Working pairs + declared spare | Spare per §BoQ |
| Optical distribution per module (module ODF) | Terminates backbone at module IDF | Boundary handoff |
| Redundant pathway | Physically separated where civil allows | Diversity, not assumed |

### 2.3 Shared technical building

| Item | Capability spec | Notes |
|---|---|---|
| Condominium core switch (HA pair) | L3, high-throughput, redundant | Shared services only |
| Shared-services servers/appliances | For CCTV mgmt, access control, IoT, observability | Sized to common-area load |
| Observability platform | Metrics/logs for shared layer | Feeds NOC / condominium dashboard |
| Structured cabling & racks | Technical-building internal | — |

### 2.4 Common-area systems

| Item | Capability spec | Notes |
|---|---|---|
| Perimeter & common IP CCTV | Cameras + NVR + storage | Own segment; bandwidth-capped |
| Access control | Gates, technical rooms, shared areas | — |
| Shared IoT gateways & sensors | Energy metering, environmental (technical rooms) | Low-power mesh + wired where apt |

### 2.5 Power (shared / critical domain)

| Item | Capability spec | Notes |
|---|---|---|
| UPS (critical technical domain) | N+1, autonomy to generator start | Tier III-inspired posture |
| Generator | Sized to critical domain (+ agreed tenant headroom) | Concurrent maintainability |
| ATS / distribution | Automatic transfer, monitored | — |
| Grounding & surge protection | Per site, explicit | Grid instability is real |
| Power monitoring | Into observability | Per-module consumption visibility |

### 2.6 Cloud on-ramp (optional shared service)

| Item | Capability spec | Notes |
|---|---|---|
| Aggregation / edge router at meet-me | Terminates tenant hybrid links | See [`06-CLOUD-CONNECT.md`](06-CLOUD-CONNECT.md) |
| Cross-connect to carrier/colocation | For Direct Connect / VPN paths | Terminates on VGW/TGW cloud-side, never IGW |

---

## 3. BoQ — quantities (illustrative template)

### 3.1 Per module

| Resource | Qty (template) | Scales with |
|---|---|---|
| Backbone fibre pairs (working) | *n* | Tenant WAN + services |
| Backbone fibre pairs (spare) | *≥ working* | Future tenant, subdivision, 2nd carrier |
| Module ODF | 1 | — |
| Meet-me cross-connect ports | defined | Tenant carrier + growth |
| Rack units in module technical space | defined U | Tenant edge/switch/NVR/OT |
| Critical power to module (kVA) | defined | IT + PoE + NVR |
| Containment entries (IT / OT separate) | 2 | Determinism |
| Antenna positions (roof/wall) | defined | Wi-Fi + wireless backup |

### 3.2 Per park (phase)

| Resource | Qty (template) | Scales with |
|---|---|---|
| Meet-me carrier positions | ≥2 | Neutrality, diversity |
| Core switch HA pair | 1 | Shared services |
| UPS + generator (critical) | 1 system, N+1 | Whole critical domain |
| Perimeter CCTV cameras | per perimeter length + docks | Coverage |
| Access-control points | per gate + technical room | — |
| Observability platform | 1 | Whole shared layer |

*The park grows in phases; each new module instantiates the §3.1 template, so
quantities scale linearly and predictably — the operational argument for the whole
condominium model.*

---

## 4. LOE — level of effort (services)

The vaga asks for "estimativas de esforço de serviços". Structured by phase, in
effort bands rather than invented hours (a real LOE is priced after vendor selection):

| Service | Effort driver | Band |
|---|---|---|
| Discovery & requirements | Site complexity, tenant count | Establishes everything downstream |
| Site survey (fibre, power, RF-relevant civil) | Site size, brownfield vs greenfield | Feeds design & risk |
| HLD & interface spec | Module count, tenant profiles | Core design effort |
| BoM/BoQ & vendor selection | Number of capability areas | Procurement-facing |
| Meet-me & backbone build oversight | Fibre runs, carriers | Delivery oversight, not execution |
| Power system commissioning | Critical-domain scope | Includes acceptance testing |
| Common-area systems integration | CCTV/access/IoT scope | Integration + validation |
| Observability enablement | Shared elements instrumented | Enables handover |
| Acceptance & handover | Per-module interface acceptance | Gate to tenant build |

The architect **oversees and validates** these; execution is by delivery teams and
integrators (see [`governance/RACI.md`](governance/RACI.md)) — consistent with the
role's boundary.

---

## 5. What is deliberately NOT in this BoM

Tenant APs, tenant switches, tenant NVR, OT/automation equipment, WMS/ERP, tenant
antennas — all tenant scope, enumerated as interface in
[`03-TENANT-INTERFACE-SPEC.md`](03-TENANT-INTERFACE-SPEC.md). Including them here
would blur the boundary the whole design defends.

---

## 6. Cost linkage

Every line here maps to a capital or operational figure in
[`05-TCO-ROI.md`](05-TCO-ROI.md), and every quantity traces back to a driver in
[`01-DISCOVERY.md`](01-DISCOVERY.md) §6. A BoM item that cannot be traced to a driver
does not belong in the design.

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
