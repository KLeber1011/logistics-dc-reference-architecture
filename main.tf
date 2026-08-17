# Illustrative Terraform skeleton — logistics-dc cloud on-ramp slice
# Free-tier friendly. NOT production. Apply in a personal account, then destroy.
# Proves: multi-tenant isolation, OT/IT segregation, private S3 access (no IGW/NAT).

terraform {
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" { region = "us-east-1" }

# --- Services VPC (shared) ---
resource "aws_vpc" "services" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "vpc-services" }
}

# --- Tenant A VPC ---
resource "aws_vpc" "tenant_a" {
  cidr_block = "10.20.0.0/16"
  tags = { Name = "vpc-tenant-a" }
}

# Isolated (OT-adjacent) subnet in tenant A — NO internet route
resource "aws_subnet" "a_ot_isolated" {
  vpc_id     = aws_vpc.tenant_a.id
  cidr_block = "10.20.20.0/24"
  tags = { Name = "a-ot-isolated" }
}
resource "aws_route_table" "a_ot_isolated" {
  vpc_id = aws_vpc.tenant_a.id
  # deliberately NO 0.0.0.0/0 route — isolation by design (ADR-0004)
  tags = { Name = "rt-a-ot-isolated" }
}
resource "aws_route_table_association" "a_ot" {
  subnet_id      = aws_subnet.a_ot_isolated.id
  route_table_id = aws_route_table.a_ot_isolated.id
}

# Gateway VPC Endpoint for S3 — private access, no IGW/NAT
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.tenant_a.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.a_ot_isolated.id]
  tags = { Name = "vpce-s3-tenant-a" }
}

# --- Tenant B VPC (to prove non-transitive peering) ---
resource "aws_vpc" "tenant_b" {
  cidr_block = "10.30.0.0/16"
  tags = { Name = "vpc-tenant-b" }
}

# Peering: A<->services and B<->services, but NOT A<->B (non-transitive => isolation)
resource "aws_vpc_peering_connection" "a_svc" {
  vpc_id      = aws_vpc.tenant_a.id
  peer_vpc_id = aws_vpc.services.id
  auto_accept = true
  tags = { Name = "peer-a-services" }
}
resource "aws_vpc_peering_connection" "b_svc" {
  vpc_id      = aws_vpc.tenant_b.id
  peer_vpc_id = aws_vpc.services.id
  auto_accept = true
  tags = { Name = "peer-b-services" }
}

# --- S3 sink (CCTV/IoT archive) with lifecycle ---
resource "aws_s3_bucket" "sink" {
  bucket_prefix = "logistics-dc-sink-"
  tags = { Name = "cctv-iot-sink" }
}
resource "aws_s3_bucket_lifecycle_configuration" "sink" {
  bucket = aws_s3_bucket.sink.id
  rule {
    id     = "archive"
    status = "Enabled"
    transition { days = 30 storage_class = "GLACIER" }
  }
}
