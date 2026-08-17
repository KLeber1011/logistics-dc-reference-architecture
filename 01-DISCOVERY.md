# 01 — Discovery
## Multi-Tenant Logistics Condominium — Shared Technology Infrastructure

> **Reference architecture / design exercise.** Greenfield study, not a client
> deliverable. The scenario is modeled on the **public profile** of the Greater São
> Paulo logistics market (Guarulhos / Marginal Tietê corridor) as a realistic sizing
> reference. No internal data, topology or confidential information from any company
> is used. All figures are illustrative or drawn from public market reporting.

---

## 1. Why this document exists

Discovery precedes design. Everything in the HLD, the BoM and the TCO is only
defensible if the drivers, stakeholders, requirements and constraints were
established first. This artifact records **what the client is trying to achieve and
why**, before a single technical decision is made.

---

## 2. Market context — why this project exists

Brazilian logistics real estate is in an expansion cycle concentrated in Greater São
Paulo. Public market reporting places the state's installed stock in the order of
19.5 million m², with several million m² of new inventory scheduled nationally
through 2026. The Guarulhos / Marginal Tietê corridor is the densest node of that
expansion: dozens of condominium developments, millions of m² delivered and hundreds
of thousands of m² under construction, driven by proximity to the airport, the
Marginal ring and the Dutra/Ayrton Senna axes.

Three shifts turn this from a real-estate story into an **infrastructure** story:

**The warehouse became a technology facility.** Modern distribution operations run
WMS, conveyor and sorter automation, dense handheld and vehicle-mounted terminal
fleets, IP CCTV at scale, and process IoT. The building is no longer a passive shed;
it is a site with a technical room, a power profile and a connectivity profile.

**Technology readiness became a leasing differentiator.** Developers increasingly
advertise electrical systems prepared for automation, robust connectivity and shared
services as part of the product. A module that is *ready* to host an automated
operation leases faster and holds better rent than one where the tenant must build
everything from scratch.

**The economics of the operation changed the risk.** In retail, a connectivity
failure costs a sale. In distribution, it stops the line: terminals stop picking,
despatch stops, the sorter halts. The industry formulation is blunt —
**an IT outage is a production outage.** That single sentence is what justifies
engineering availability here closer to a small data centre than to an office.

**The emerging vertical.** Taken together, logistics condominiums are becoming a new
demand vertical for dedicated IT services, critical power and cloud on-ramp — at
megaproject scale, and delivered as shared infrastructure rather than as one-off
tenant builds. That is the market this exercise addresses.

---

## 3. The intent and the need

**The client:** a logistics condominium developer (landlord) building a multi-module
park with multiple tenants, one of them an anchor e-commerce / distribution operator.

**The intent (what the client wants to achieve):**

1. **Lease faster and at better terms** by delivering modules that are demonstrably
   ready for automated, technology-intensive operations.
2. **Avoid becoming a telecom operator.** The developer wants to provide a *capable
   and neutral* physical layer — not to run tenants' networks or to be liable for
   their applications.
3. **Standardise across modules and future phases,** so a new tenant is onboarded by
   instantiating a template rather than by renegotiating infrastructure each time.
4. **Control long-term cost and risk** on the assets it does own: entrance facility,
   backbone, technical rooms, critical power, common-area systems.

**The need (why an architect is engaged):**

The developer's core competence is building and operating real estate. It does not
hold in-house competence in carrier entrance design, optical backbone dimensioning,
multi-tenant network segregation, critical-power posture, or cloud on-ramp. Those
decisions are made once, at fit-out, and are expensive or impossible to reverse
afterwards — spare fibre count, riser and containment capacity, technical-room
footprint, electrical headroom, antenna and rooftop rights.

That is the gap this engagement fills: an **infrastructure and solutions architect,
working for the integrator engaged by the developer**, who converts commercial intent
into a defensible technical specification — and into the boundary contract that
governs what the landlord delivers and what each tenant owns.

---

## 4. Our position in the value chain

| Agent | Role in this project |
|---|---|
| **Developer / landlord** | Client. Owns the asset and the commercial intent. |
| **Construction contractor** | Executes civil works; consumes our specifications for pathways, technical rooms and electrical provisioning. |
| **Integrator (our employer)** | Designs, specifies, proposes and oversees delivery of the shared technology infrastructure. |
| **Solutions Architect (this role)** | Owns discovery, HLD, interface spec, BoM/BoQ, TCO and technical defence. |
| **Carrier / ISP** | Delivers last mile to the entrance facility. External dependency, long lead time. |
| **Tenants / operators** | Consume the shared layer; own their internal networks and applications. |
| **Automation vendors** | Impose requirements on the tenant's OT network; consume power and space specifications. |

Our authority ends at the design and the specification. Delivery is owned by the
project function and gated by engineering, security and procurement — recorded in
`governance/RACI.md` and bounded in `governance/SOW.md`.

---

## 5. Stakeholders and what each one needs from us

| Stakeholder | Primary concern | What they need from the architecture |
|---|---|---|
| Developer board / investment | Yield, vacancy, differentiation | Infrastructure as a leasing argument, with cost and payback stated |
| Development / engineering (landlord) | Buildability, schedule | Specifications early enough to enter the civil design |
| Commercial / leasing | Tenant objections during negotiation | A clear, sellable statement of what comes with the module |
| Facilities / operations (landlord) | Long-term operability and cost | Maintainable, monitored, standardised infrastructure |
| Anchor tenant (e-commerce DC) | Operational continuity | Guaranteed capacity, isolation, and a boundary they can build on |
| Other tenants | Fairness and independence | Neutrality — no tenant advantaged or exposed by another |
| Carrier | Feasibility and access | A defined entrance facility and meet-me point |
| Integrator (our side) | Deliverable scope and margin | An explicit boundary between design, delivery and tenant scope |

---

## 6. Business drivers (ranked)

1. **Time-to-lease** — modules that are technology-ready are commercially ready.
2. **Neutrality** — the landlord must serve any tenant and any carrier without
   favouring either; neutrality is the product.
3. **Operational continuity for tenants** — because an IT outage is a production
   outage, and continuity is what tenants pay a premium for.
4. **Capital efficiency** — build headroom once, at fit-out, where it is cheap;
   avoid retrofit, which is not.
5. **Standardisation and scale** — the park grows in phases; the model must repeat.
6. **Bounded liability** — the landlord's exposure must stop at a documented
   interface.

---

## 7. Requirements

### 7.1 Functional (shared infrastructure — our scope)

- Carrier entrance facility and meet-me point serving all modules, supporting more
  than one carrier.
- Optical backbone from the shared technical building to each module, with spare
  capacity provisioned for future tenants and phases.
- A shared technical building and a dedicated technical space per module.
- Critical power protection and continuity for technical areas.
- Common-area systems: perimeter and common-area IP CCTV, access control, shared
  environmental and energy IoT.
- Condominium-level observability of the shared layer.
- A shared cloud on-ramp offering, which a tenant may consume or bypass.
- Physical and logical isolation between tenants.

### 7.2 Interface requirements (tenant side — *specified, not designed by us*)

These exist because the shared layer must **support** them, not because we design
them. They are formalised in `03-TENANT-INTERFACE-SPEC.md`.

- High-density Wi-Fi across floor, mezzanine, docks and yard — drives AP count, PoE
  budget, cabling pathways and rooftop/wall antenna rights.
- Industrial OT networks (e.g. Profinet, Profibus) with determinism requirements —
  drives segregation, containment separation and EMI considerations.
- Low-power IoT mesh and RFID — drives spectrum coordination and portal positioning.
- Tenant IP CCTV and storage — drives rack units, power draw and cooling.
- Tenant WAN and cloud connectivity — drives fibre count and meet-me access.

### 7.3 Non-functional

- **Availability:** shared technical room and core designed on **Tier III-inspired**
  principles — concurrent maintainability, N+1 on critical elements. *Design posture,
  not a claim of Uptime Institute certification, which applies to data centres.*
- **Neutrality:** no carrier or tenant structurally advantaged.
- **Scalability:** new module or tenant onboarded from a template.
- **Maintainability:** shared elements serviceable without tenant downtime.
- **Observability:** shared layer instrumented and visible.
- **Security:** enforced tenant-to-tenant isolation; controlled access to technical
  areas.

---

## 8. Constraints and assumptions

- **Carrier route diversity to the site is not assumed.** A physically diverse second
  entrance may require a special project with distinct cost and lead time — to be
  established by survey, exactly as in the retail case.
- **Greenfield advantage:** because the park is in construction or fit-out, pathways,
  technical rooms and electrical headroom can be *specified*, not retrofitted. This
  is the cheapest moment to get it right and the whole reason discovery happens now.
- **Warehouse RF cannot be designed from a floor plan** — height, racking and moving
  inventory require on-site survey and re-validation after stocking. Relevant to us
  as a driver of AP density, cabling and power, not as our design deliverable.
- **Automation vendors dictate their own control protocols;** the infrastructure
  accommodates them.
- **Grid quality varies** and is a real failure source; grounding and surge
  protection are explicit, not assumed.
- Tenant identities beyond the anchor are unknown at design time — the model must be
  tenant-agnostic.

---

## 9. Out of scope

Civil and structural works · WMS/ERP software · tenant internal network design ·
fire detection and suppression engineering · physical security manpower · carrier
last-mile civil execution · automation equipment selection. Formalised in
`governance/SOW.md`.

---

## 10. Open questions — to be resolved by survey

1. Is a physically diverse carrier route available to the site, and at what cost and
   lead time?
2. What is the utility supply profile and outage history at this location?
3. What technical-room footprint and electrical headroom can the civil design still
   absorb without rework?
4. What spare fibre count per module is commercially justified?
5. What rooftop and wall rights will tenants require for antennas?
6. Which shared services will the developer operate itself versus contract out?

These feed `08-SITE-SURVEY.md` and, through it, the roadmap and the TCO.

---

## 11. Success criteria for this engagement

- Every module can be marketed as technology-ready with a specific, written
  statement of what is included.
- A tenant can be onboarded without renegotiating the shared infrastructure.
- The landlord's liability stops at a documented interface.
- Shared-layer availability meets the stated posture, evidenced by testing.
- Capital decisions are traceable to a driver in section 6 and a number in
  `05-TCO-ROI.md`.

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes. Scenario inspired by the public profile of the
Greater São Paulo logistics market; contains no confidential or client data.*
