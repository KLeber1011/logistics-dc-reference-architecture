# Topology — shared infrastructure

```mermaid
graph TB
    CA["Carrier A"]; CB["Carrier B (where viable)"]
    subgraph MEET["Entrance / Meet-me (landlord, neutral)"]
      ODF["Cross-connect frame"]
    end
    subgraph TECH["Shared Technical Building"]
      CORE["Core switch (HA)"]; UPS["UPS N+1 + Generator"]
      OBS["Observability (shared layer)"]; SVC["Shared services: CCTV/Access/IoT"]
    end
    CA --- ODF; CB --- ODF
    ODF --- CORE; UPS -.powers.- CORE; OBS -.monitors.- CORE
    CORE === M1["Module 1 IDF"]; CORE === M2["Module 2 IDF"]; CORE === M3["Module n IDF"]
    M1 --> B1["» tenant scope: edge, Wi-Fi, OT, NVR, WMS"]
    M2 --> B2["» tenant scope"]
    M3 --> B3["» tenant scope"]
    classDef ll fill:#1a365d,stroke:#2d3748,color:#fff
    classDef t fill:#4a5568,stroke:#2d3748,color:#fff
    class ODF,CORE,UPS,OBS,SVC ll
    class B1,B2,B3 t
```

- Thick `===` = optical backbone (landlord) to each module IDF — the delivery boundary.
- Everything past the IDF (`»`) is tenant scope: specified as interface, not designed
  by the landlord.
- The meet-me is the single neutral convergence point; carrier and tenant WAN are the
  same physical path, not opposite sides.

## Hybrid cloud path (corrected)
```mermaid
flowchart LR
    E["Tenant edge (10.20.0.1)"] --> MM["Meet-me / carrier"]
    MM --> DX["Direct Connect / VPN"]
    DX --> VGW["VGW / Transit Gateway"]
    VGW --> VPC["VPC"]
    OT["OT-isolated subnet"] -->|Gateway Endpoint, no IGW/NAT| S3["S3"]
    classDef c fill:#22543d,stroke:#2d3748,color:#fff
    class VGW,VPC,S3 c
```
DX/VPN terminate on **VGW/TGW, never IGW**; the isolated subnet reaches S3 via a
**Gateway VPC Endpoint** with no internet path.
