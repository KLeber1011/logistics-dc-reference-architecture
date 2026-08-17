# ADR-0001 — The landlord delivers a capable, neutral physical layer — not a managed network

**Status:** Accepted

## Context
A logistics condominium developer can position itself anywhere on a spectrum from
"bare shed" to "full managed network operator". Going far up that spectrum turns the
landlord into a telecom operator — a business it does not want and is not equipped for,
with liability for tenant applications.

## Decision
The landlord delivers a **capable and neutral physical layer**: entrance, meet-me,
backbone, technical space, critical power, common-area systems and shared
observability — and stops at a documented interface. Tenants own their logical
networks and applications.

## Consequences
**Positive:** clear liability boundary; neutrality as a sellable product; the landlord
scales by template, not by operating each tenant's network.
**Trade-off:** the landlord cannot monetise managed services it chooses not to run;
some tenants may want more, met by optional shared services (e.g. cloud on-ramp),
never by default.

## Notes
This is the decision the entire case hangs from. Every other ADR is downstream of it.
