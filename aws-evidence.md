# Lab — AWS evidence (buildable slice)

> A representative slice of the cloud on-ramp, built on the AWS free tier, to prove the
> segmentation and private-access decisions are real configuration — not just diagrams.
> Companion to [`../06-CLOUD-CONNECT.md`](../06-CLOUD-CONNECT.md).

## What this slice proves
| Design decision | Lab element | Cost |
|---|---|---|
| Tenant isolation | Multi-VPC + **non-transitive** peering (A↔services, B↔services; A✗B) | Free |
| OT/IT segregation (ADR-0004) | Isolated subnet with **no internet route** | Free |
| Private service access | **Gateway VPC Endpoint (S3)** on the isolated subnet — no IGW/NAT | Free |
| "Something deployed" | S3 bucket as CCTV/IoT sink + lifecycle to Glacier | Free tier |
| Observability | VPC Flow Logs → S3 | Low cost |
| Reproducibility | Terraform (below) | Free |

## Explicitly conceptual (documented, not built)
Direct Connect, Transit Gateway, Site-to-Site VPN, Redshift, Interface Endpoints —
real circuits/services cost money; **VPC Peering simulates the on-prem→cloud enlace at
zero cost**. Being explicit about this boundary is the point.

## Billing safety
Billing alert set (e.g. US$5) before building. No NAT Gateway, no VPN, no TGW in the
buildable slice — the three usual sources of surprise cost are avoided by design.

## Terraform (illustrative skeleton)
See [`main.tf`](main.tf). It provisions: two tenant VPCs + a services VPC, non-transitive
peering, an isolated subnet with a route table that has **no 0.0.0.0/0**, a Gateway
Endpoint for S3, an S3 bucket with lifecycle, and Flow Logs. Apply with a personal
free-tier account; destroy after capturing evidence.

## Evidence to capture (for the repo / interview)
1. VPC resource map showing three VPCs and peering.
2. Route table of the isolated subnet — **no internet route**.
3. Gateway Endpoint attached to the isolated subnet.
4. `terraform plan` output.

These screenshots + the Terraform are the "deploy-as-evidence" that answers *"did you
build it, or just draw it?"*.
