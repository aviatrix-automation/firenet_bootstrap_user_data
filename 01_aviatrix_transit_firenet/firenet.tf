// List available firewall images -- run once before module firenet apply
# data "aviatrix_firewall_instance_images" "pan_images" {
#   vpc_id = module.transit_firenet_aws_1.vpc.vpc_id
#   depends_on = [
#     module.transit_firenet_aws_1
#   ]
# }

module "mc_firenet" {
  source  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version =  "v1.6.0"

  transit_module = module.transit_firenet_aws_1
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
  user_data_1 = sensitive(local.user_data_1)
  user_data_2 = sensitive(local.user_data_2)
  custom_fw_names = ["aws-us-east-1-firenet-lab-1-fw-1","aws-us-east-1-firenet-lab-1-fw-2"]
  firewall_image_version = "11.2.3-h3"
  fw_amount = "2"
  inspection_enabled = true
  instance_size = "c5.xlarge"
  attached = true
  tags = { "env" = "demo" }
}
