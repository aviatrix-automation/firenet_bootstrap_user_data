// local aviatrix
data "terraform_remote_state" "aviatrix" {
  backend = "s3"
  config = {
    bucket  = var.backup_bucket_name
    key     = "terraform/lab/hub_spoke_fabric_01/00_basic_launch_controller"
    region  = var.s3_region
  }
}

provider "aviatrix" {
  username                = "admin"
  controller_ip           = data.terraform_remote_state.aviatrix.outputs.controlplane_data.controller_public_ip
  password                = var.controller_admin_password
  skip_version_validation = true
}
