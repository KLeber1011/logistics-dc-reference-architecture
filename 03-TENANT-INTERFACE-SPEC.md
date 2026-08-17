# 03 — Tenant Interface Specification
## The landlord ↔ tenant boundary contract

> **Reference architecture / design exercise.** Companion to
> [`02-HLD.md`](02-HLD.md). This is the artifact that distinguishes a condominium
> from a single warehouse: it defines, in writing, what the landlord delivers and
> what the tenant owns — and, crucially, what the shared layer must be sized to
> **support** even though the landlord does not design it.

---

## 1. Why this document exists

The most expensive mistakes in a multi-tenant facility are made at the boundary, and
they are made by silence. If spare fibre count, rack units, power draw, containment
separation and antenna rights are not agreed **before fit-out**, they become retrofit
— disruptive, costly, sometimes impossible. This specification makes the boundary
explicit so that:

- the tenant knows exactly what it receives and what it must build;
- the landlord's liability stops at a documented line;
- the shared infrastructure is dimensioned for what tenants will actually deploy,
  not for a guess.

The tenant-side technologies below (Wi-Fi, OT, IoT, RFID, CCTV) are **not designed by
the landlord's architect**. They appear here because each one *drives a requirement*
on the shared layer — a fibre count, a power figure, a pathway, a spectrum
consideration, an antenna right. That is the whole point of an interface spec.

---

## 2. The boundary, at a glance

| Element | Landlord delivers | Tenant owns | Interface driver |
|---|---|---|---|
| Carrier entry & meet-me | Neutral entrance, cross-connect frame | Its carrier choice, its circuit | Port allocation |
| Backbone to module | Optical, working + spare fibre | Termination in its IDF | Spare fibre count |
| Module technical space | Space, power, cooling, rack allocation | Its edge, switching, NVR, OT uplink | Rack units, kVA, cooling |
| Containment | Separated IT / OT / power pathways | Cabling within its area | EMI separation |
| Rooftop / walls | Defined antenna positions & load | Its antennas (Wi-Fi, wireless backup) | Position, load, count |
| Common-area systems | Perimeter CCTV, access, shared IoT | Its internal CCTV, its process IoT | Segment isolation |
| Power | Critical & facility domains | Process/automation coordination | kVA, redundancy tier |
| WAN / cloud | Optional shared on-ramp | Free to consume or bypass | Neutrality |

---

## 3. Interface requirements by tenant technology

Each subsection states: **what the tenant deploys**, and **what the shared layer must
therefore provide**. The first is context; the second is the landlord's obligation.

### 3.1 High-density Wi-Fi (802.11)

*What the tenant deploys:* contiguous Wi-Fi across floor, mezzanine, docks and yard
for handhelds, vehicle-mounted terminals, tablets and voice picking. Coverage
originates at the module distribution switch, feeds **PoE access switches**, which
feed **access points positioned by sector** (aisles, docks, mezzanine, yard, office).
Warehouse RF is hostile — height, metal racking, moving inventory — so AP placement
follows an on-site survey and is re-validated after stocking.

*What the shared layer must provide:*
- **PoE power budget** at the module technical space sized for the projected AP count
  and switch load — a direct input to the module's kVA allocation (§3.7).
- **Cabling pathways** from the technical space to sector positions across the floor
  and to the roof line.
- **Rooftop / wall antenna rights** (§3.6) for outdoor and yard coverage.
- **Spectrum coordination** with the IoT mesh (§3.3), so the two radio layers coexist.

### 3.2 OT — industrial / automation network (Profinet, Profibus)

*What the tenant deploys:* automation control (conveyors, sorters, PLCs, drives) on
deterministic industrial protocols such as **Profinet and Profibus**, on
industrial-grade cabling and hardened equipment, physically and logically **segregated**
from tenant IT. Any OT↔IT communication (e.g. WMS instructing the sorter) crosses a
controlled, documented boundary — never a flat adjacency.

*What the shared layer must provide:*
- **Separated containment** for OT runs, away from power and IT, to protect
  determinism from EMI — a civil-design input that must enter before construction.
- **Power headroom** for the process domain, coordinated with the automation vendor's
  requirement (§3.7).
- **No shared-network adjacency**: the landlord's common services must never create a
  path into the tenant's OT segment.

### 3.3 Low-power IoT mesh (e.g. Zigbee, 802.15.4)

*What the tenant deploys:* a distinct low-power mesh for environmental, energy and
asset sensors — a different job from Wi-Fi (telemetry, not throughput). Positioned
here as a **coexisting radio layer**, not detailed.

*What the shared layer must provide:*
- **Spectrum coordination** so the mesh and Wi-Fi do not interfere — planned, not
  discovered after deployment.
- Gateway positions and the small power/space they need in the technical area.

### 3.4 RFID

*What the tenant deploys:* asset and pallet identification at portals and docks.
Positioned as a **use-case layer**; portal placement interacts with RF planning.

*What the shared layer must provide:*
- Portal positions coordinated with pathways and power at docks.
- Awareness in the RF plan so readers and Wi-Fi/IoT do not degrade each other.

### 3.5 Tenant IP CCTV

*What the tenant deploys:* internal surveillance of its own operation, on its own
segment, with its own NVR and storage.

*What the shared layer must provide:*
- **Rack units, power and cooling** in the module technical space for the NVR and
  storage (§3.7).
- Segment isolation from the landlord's common-area CCTV — the two never share a
  network, for both privacy and liability.

### 3.6 Rooftop and wall antenna rights

*What the tenant deploys:* outdoor/yard Wi-Fi and wireless WAN backup (4G/5G)
antennas.

*What the shared layer must provide:*
- **Defined positions, structural load allowance and cable paths** to the roof and
  external walls, allocated per module and recorded — because roof rights are a
  common source of dispute once tenants coexist.

### 3.7 The module technical space — the quantified boundary

This is where the boundary becomes numbers. Per module, the landlord commits:

| Resource | Committed (illustrative template) | Driven by |
|---|---|---|
| Rack units | Defined U allocation | Tenant edge, switching, NVR, OT uplink |
| Power (critical domain) | Defined kVA with headroom | IT + PoE (Wi-Fi) + NVR load |
| Power (process domain) | Coordinated with automation vendor | OT / conveyors / drives |
| Cooling | To the committed power figure | Heat of the above |
| Backbone fibre | Working pairs + declared spare | Future tenant, subdivision, 2nd carrier |
| Meet-me ports | Defined cross-connect allocation | Tenant's own carrier |
| Containment entries | Separate IT and OT | Determinism / EMI |
| Antenna positions | Defined count and load | Wi-Fi + wireless backup |

Quantities are set in [`04-BOM-BOQ.md`](04-BOM-BOQ.md) and costed in
[`05-TCO-ROI.md`](05-TCO-ROI.md).

---

## 4. Responsibility matrix (interface level)

| Concern | Landlord | Tenant |
|---|---|---|
| Physical path to the world (entry, backbone, meet-me) | ✔ | — |
| Space, power, cooling in the module | ✔ | Consumes within allocation |
| Determinism-safe containment | ✔ (provides) | ✔ (uses correctly) |
| Antenna structural provision | ✔ | Installs its antennas |
| Wi-Fi / OT / IoT / RFID design & operation | — | ✔ |
| Tenant CCTV & WMS | — | ✔ |
| Isolation from other tenants | ✔ (enforces on shared) | ✔ (does not breach) |
| Monitoring of shared elements | ✔ | — |
| Monitoring of tenant network | — | ✔ |

---

## 5. Change control

Any change that crosses the boundary — more fibre, more power, more U, new antenna
positions — follows a documented change process, because after fit-out these are
retrofits. The interface spec is versioned; a tenant's accepted allocation is the
baseline against which change is measured.

---

## 6. Acceptance

A tenant's interface is accepted when the committed resources in §3.7 are delivered,
measured and signed — rack units available, kVA verified, spare fibre counted,
antenna positions provided, containment separated. This acceptance is a precondition
for the tenant to begin its own build, and a milestone in [`09-ROADMAP.md`](09-ROADMAP.md).

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
