# ADR-0003 — Availability is Tier III-inspired, explicitly not Uptime-certified

**Status:** Accepted

## Context
The critical technical domain (meet-me, core, IDFs, shared NVR) needs data-centre-grade
availability thinking. But a logistics facility is not a data centre, and claiming an
Uptime Institute Tier certification it does not hold would be false.

## Decision
Engineer the critical domain on **Tier III-inspired principles** — concurrent
maintainability, N+1 on critical elements — and state explicitly that this is a design
posture, **not** an Uptime Institute certification, which applies to data centres.

## Consequences
**Positive:** real availability engineering; honest positioning that a knowledgeable
reviewer trusts *more*, not less.
**Trade-off:** cannot market a "Tier III certified" badge — correctly, because it isn't.

## Notes
Naming the boundary of a claim is a seniority signal. Over-claiming certification is
the fastest way to lose a technical reviewer.
