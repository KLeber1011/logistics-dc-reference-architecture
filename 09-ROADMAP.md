# 09 — Roadmap — phasing & dependencies

> **Reference architecture / design exercise.** Phasing follows survey and civil
> schedule, not a guessed calendar. No fixed durations are asserted; stating that
> honestly is stronger than inventing dates.

## Phasing logic

The park is greenfield and grows in modules, so the roadmap is **construction-aligned**:
shared foundation first, then modules as they are built and let. Long-lead external
dependencies (carrier special projects, generator) are triggered at the start.

| Phase | Focus | Depends on |
|---|---|---|
| **0 — Foundation** | Survey; meet-me & entrance; core; critical power; observability; **fire carrier special-project requests** if diverse route needed | Survey; procurement; carrier |
| **1 — First modules** | Backbone + technical space for the first built modules; anchor tenant interface acceptance | Phase 0 live; civil handover of modules |
| **2 — Fit-out waves** | Remaining modules instantiate the template as built | Phase 1 proven; standard kit procured |
| **3 — Tenant onboarding (ongoing)** | Per-tenant interface acceptance → tenant begins its build | Module technical space delivered & signed |

## Dependency matrix

| Deliverable | Internal dependency | External dependency | Blocking? |
|---|---|---|---|
| Meet-me & entrance | Engineering, facilities | Carrier(s) | Yes — gates everything |
| Diverse carrier route | Procurement | **Carrier special-project** (long lead) | Yes, if pursued |
| Critical power | Facilities/engineering | UPS/generator supplier | Yes — gates availability posture |
| Backbone to module | Engineering | — | Per module |
| Interface acceptance | All shared elements | — | Yes — gates tenant build |
| Cloud on-ramp | Cloud/platform | Cloud/carrier | Only if offered |

**The external dependency sets the critical path.** A diverse carrier route or a
generator has a lead time measured in months — surfaced in Phase 0, not discovered
late. This is where the architect's design meets program reality; ownership is in
[`governance/RACI.md`](governance/RACI.md).

---
*Author: Kleber Nascimento — Infrastructure & Solutions Architect. Reference
architecture for portfolio purposes; contains no confidential or client data.*
