# 07 — Technical Proposal (executive summary)

> **Reference architecture / design exercise.** The C-level-facing artifact: the whole
> case in the language a decision-maker reads. It stands on the detailed artifacts but
> does not repeat them.

## The proposition

Turn each warehouse module from a bare shed into a **technology-ready, connected,
resilient** asset by building a shared infrastructure layer once, at fit-out — leasing
faster, at better rent, with lower retrofit risk, in a corridor where dozens of
developments compete on being ready for automated operations.

## Why now

Logistics real estate in Greater São Paulo is expanding fast, the warehouse became a
technology facility, and **an IT outage is a production outage**. Technology-readiness
has moved from nice-to-have to leasing differentiator. The cheapest moment to build it
is during construction; the most expensive is after.

## What we deliver (shared scope)

- A **neutral** entrance and meet-me serving any carrier and any tenant.
- An **optical backbone** with spare capacity for future tenants and phases.
- **Critical power** on Tier III-inspired principles (posture, not certification).
- **Common-area** CCTV, access, IoT and **shared observability**.
- An optional **cloud on-ramp**, private and correct (DX/VPN→VGW; private access via
  VPC Endpoint).
- A written **landlord↔tenant interface** that bounds liability and prevents retrofit
  disputes.

## What the tenant keeps

Its own Wi-Fi, OT (Profinet/Profibus), IoT, RFID, CCTV and WMS — we size the shared
layer to *support* these, we do not design them. Neutrality is the product.

## The number

Front-loaded CAPEX (power and backbone lead), low marginal cost per additional module,
and a return led by **time-to-lease**, plus rent premium, retention, avoided retrofit
and differentiation. Defended as **scenarios**, not a single figure, because that is
how a TCO survives a boardroom. Detail in [`05-TCO-ROI.md`](05-TCO-ROI.md).

## The honest edges

- A diverse carrier route may be a special project (cost, lead time) — surveyed, not
  assumed.
- Part of last-mile/grid risk on some sites is managed, not eliminated — stated plainly.
- The cloud on-ramp is optional; tenants may bring their own — by design.

## Why this architect

The design pairs deep transport/OSS-BSS background with the two languages the role
needs: the technical (backbone, power, segmentation, cloud on-ramp) and the financial
(CAPEX/OPEX, TCO, ROI, risk). Every technical decision here traces to a business driver
and a number — which is the whole job.

---
*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
