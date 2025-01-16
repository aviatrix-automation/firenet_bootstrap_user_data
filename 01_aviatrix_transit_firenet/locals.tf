//this is for lab only, in prod environment secret should be pulled from vault itself
data "terraform_remote_state" "git_vault" {
  backend = "s3"
  config = {
    bucket  = var.backup_bucket_name
    key     = "terraform/lab/hub_spoke_fabric_01/000_github_vault"
    region  = var.s3_region
  }
}

locals {
  user_data_1 = <<-EOF
  type=dhcp-client
  hostname=aws-us-east-1-firenet-lab-1-fw-1
  panorama-server=10.77.1.2
  panorama-server-2=10.77.1.3
  tplname=STK-NGFW-01
  dgname=DG-NGFW
  dns-primary=169.254.169.253
  dns-secondary=8.8.8.8
  op-command-modes=mgmt-interface-swap
  dhcp-send-hostname=yes
  dhcp-send-client-id=yes
  dhcp-accept-server-hostname=yes
  dhcp-accept-server-domain=yes

  vm-auth-key=${data.terraform_remote_state.git_vault.outputs.firenet-pan-vm-auth-keys[0]}
  authcodes=${data.terraform_remote_state.git_vault.outputs.firenet-pan-authcodes[0]}
  EOF

  user_data_2 = <<-EOF
  type=dhcp-client
  hostname=aws-us-east-1-firenet-lab-1-fw-2
  panorama-server=10.77.1.2
  panorama-server-2=10.77.1.3
  tplname=STK-NGFW-02
  dgname=DG-NGFW
  dns-primary=169.254.169.253
  dns-secondary=8.8.8.8
  op-command-modes=mgmt-interface-swap
  dhcp-send-hostname=yes
  dhcp-send-client-id=yes
  dhcp-accept-server-hostname=yes
  dhcp-accept-server-domain=yes

  vm-auth-key=${data.terraform_remote_state.git_vault.outputs.firenet-pan-vm-auth-keys[1]}
  authcodes=${data.terraform_remote_state.git_vault.outputs.firenet-pan-authcodes[1]}
  EOF
}
