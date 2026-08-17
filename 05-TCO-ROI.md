# 05 — TCO / ROI
## The business case for shared infrastructure

> **Reference architecture / design exercise.** This artifact translates the design
> into the language the decision is actually made in: capital, operating cost, payback
> and risk. Figures are **illustrative and directional** — the structure of the
> argument is the deliverable, not the specific numbers. Companion to
> [`04-BOM-BOQ.md`](04-BOM-BOQ.md).

---

## 1. Whose business case is this?

The client is the **developer / landlord** ([`01-DISCOVERY.md`](01-DISCOVERY.md)).
The business case is therefore the landlord's, and it has two sides:

- **Cost** of building the shared technology layer (CAPEX) and running it (OPEX).
- **Return**: faster leasing, better rent, lower vacancy, and a defensible,
  differentiated product — plus avoided cost of retrofit.

A tenant-side TCO (the DC operator's own case) is a separate document; here we make
the *landlord's* case, because that is who engaged the architect.

---

## 2. The core argument in one line

> Building technology-readiness **once, at fit-out**, is a fraction of the cost of
> retrofitting it per tenant later — and it converts the module from a commodity shed
> into a differentiated, faster-leasing, higher-rent asset.

Everything below quantifies that sentence.

---

## 3. CAPEX — build the shared layer once

Grouped by the BoM areas, as capital bands (illustrative):

| CAPEX area | Driver | Relative weight |
|---|---|---|
| Entrance facility & meet-me | Carrier count, neutrality | Low–medium |
| Optical backbone (with spare fibre) | Module count, spare ratio | Medium |
| Shared technical building & core | Shared-services scope | Medium |
| Critical power (UPS + generator) | Tier III-inspired critical domain | **High** |
| Common-area CCTV / access / IoT | Perimeter + docks | Medium |
| Observability platform | Shared layer scope | Low–medium |
| Cloud on-ramp (optional) | If offered as shared service | Low |

**The spare-fibre decision is the signature CAPEX call.** Adding spare fibre during
the civil works is a marginal cost; pulling new fibre through occupied, operating
modules later is a major project. The design provisions spare now precisely because
the TCO of doing it later is disproportionate.

---

## 4. OPEX — run it

| OPEX area | Nature | Note |
|---|---|---|
| Power (technical domains) | Recurring | Monitored per module; chargeable/allocable |
| Maintenance (power, CCTV, access, network) | Recurring | Predictable with standardised kit |
| Observability & monitoring | Recurring | Enables proactive maintenance, lowers incident cost |
| Carrier / meet-me operations | Recurring | Neutral; tenants contract their own circuits |
| Shared-services support | Recurring | Scales sub-linearly with modules (shared) |

The condominium model's OPEX advantage is **sharing**: one critical-power system, one
observability platform, one meet-me serve many modules — so per-module OPEX falls as
the park grows. That is the operational half of the leasing argument.

---

## 5. TCO comparison — shared vs per-tenant build

The decision the landlord is really weighing:

| Dimension | **Shared (this design)** | **Per-tenant, ad hoc** |
|---|---|---|
| Fibre & pathways | Provisioned once, spare included | Re-pulled per tenant; disruptive |
| Critical power | One N+1 system, shared | Each tenant improvises; uneven |
| Meet-me / carrier | Neutral, shared, any-carrier | Each tenant negotiates entry |
| Standardisation | Template per module | Bespoke every time |
| Onboarding a new tenant | Instantiate template | Renegotiate infrastructure |
| Marketing | "Technology-ready" as product | "Bare shed" |
| Retrofit risk | Low (headroom built in) | High (constant retrofit) |
| **TCO trajectory** | **Front-loaded CAPEX, low marginal cost** | **Low upfront, high cumulative cost & friction** |

The shared model costs more upfront and less over the asset's life — and, critically,
it *earns* more, which the ad-hoc model cannot (section 6).

---

## 6. ROI — where the return comes from

The landlord's return is not cost savings alone; it is **revenue and risk**:

1. **Time-to-lease.** A technology-ready module leases faster. Every month of reduced
   vacancy on a large module is direct revenue. This is usually the single largest
   ROI lever.
2. **Rent premium.** Automation-ready, connected, resilient modules command better
   rent than bare sheds — a recurring uplift over the lease term.
3. **Tenant retention.** Operations that run reliably (because power and connectivity
   were engineered, not improvised) renew. Churn is expensive.
4. **Avoided retrofit cost.** Every capability built at fit-out is a retrofit not paid
   for later — a real, if defensive, return.
5. **Differentiation.** In a corridor with dozens of competing developments
   ([`01-DISCOVERY.md`](01-DISCOVERY.md) §2), technology-readiness is a reason to
   choose this park over the one next door.

**Payback framing:** the CAPEX is justified when the sum of (faster leasing + rent
premium + avoided retrofit) recovers the front-loaded investment within the asset's
planning horizon. The model is sensitive above all to **vacancy reduction** — which
is why time-to-lease leads the ROI story to a developer board.

---

## 7. Scenarios

| Scenario | Assumption | Effect on the case |
|---|---|---|
| **Base** | Park leases at market pace | CAPEX recovered via premium + avoided retrofit |
| **Fast-lease** | Readiness cuts vacancy materially | ROI dominated by revenue-brought-forward; strongest case |
| **Slow market** | Leasing lags | Avoided-retrofit and differentiation carry the case; still positive vs ad-hoc |
| **Single anchor** | One large tenant takes most space | Case simplifies; interface spec becomes bilateral, spare fibre still justified for phase 2 |

Presenting scenarios — not a single number — is the honest way to defend a TCO to a
C-level, and it is what the Logicalis role means by "evidenciando o TCO e o ROI".

---

## 8. What would change these numbers

- **Carrier diversity as a special project** (no off-the-shelf second route) raises
  CAPEX and lead time — a survey outcome, flagged in [`10-RISKS.md`](10-RISKS.md).
- **Grid quality** worse than assumed raises power-domain CAPEX (more autonomy,
  stronger protection).
- **Tenant mix** heavier on automation raises process-power and containment needs.

Each is traceable to a driver and a risk — the discipline that lets an architect
defend a number instead of asserting it.

---

*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; figures illustrative; contains no confidential
or client data.*
