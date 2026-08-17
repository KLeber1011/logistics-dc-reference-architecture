# 08 — Site Survey — methodology

> **Reference architecture / design exercise.** The survey converts the HLD's
> assumptions into verified facts. Greenfield advantage: run during construction /
> fit-out, it *anticipates* rather than *constates*. Companion to [`02-HLD.md`](02-HLD.md).

## Why the survey precedes commitment

Every quantity in the BoQ and every figure in the TCO rests on facts the survey
establishes. Committing spare fibre, kVA and antenna rights without survey is
guessing with the landlord's capital.

## Dimensions

### 1. Carrier fibre & route diversity
- Which carriers can reach the site, and by which physical routes?
- Does a **physically diverse** second route exist, or would it be a special project
  (cost, lead time)? — the single most important connectivity finding.

### 2. Power
- Utility feed profile; local **outage history** (materially worse in some peri-urban
  logistics zones).
- Spare capacity for the critical technical domain and process (automation) headroom.
- Grounding and surge posture — explicit, given grid instability.

### 3. Civil constraints that bind the network (greenfield window)
- Technical-room footprint still absorbable without rework.
- **Containment routes**, separable into IT and OT (determinism/EMI).
- Riser and pathway capacity, with declared spare.
- Roof/wall structural allowance for tenant antennas.

### 4. RF-relevant context (for the tenant's design, sized by us as interface)
- Building height, structure and racking that will shape tenant Wi-Fi — noted so the
  shared layer provides adequate PoE power, pathways and antenna rights.
- *Tenant runs the actual RF survey; we ensure the infrastructure supports it.*

## Brownfield vs greenfield

| | Brownfield (existing park) | Greenfield (in construction) |
|---|---|---|
| Survey role | Discover what exists | **Anticipate** — feed civil design |
| Diversity | Often reactive, costly | Requestable ahead, in CAPEX |
| Containment | Retrofit constraints | Specified from day one |
| Cost/time | Sunk constraints | Planned line items |

## Output → per-site record

Feeds the [`04-BOM-BOQ.md`](04-BOM-BOQ.md) quantities, the
[`05-TCO-ROI.md`](05-TCO-ROI.md) figures, and the [`10-RISKS.md`](10-RISKS.md)
register. A quantity without a survey fact behind it is flagged as an assumption.

---
*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
