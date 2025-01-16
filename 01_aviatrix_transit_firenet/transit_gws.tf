module "transit_firenet_aws_1" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.6.0"

  cloud                        = "aws"
  region                       = "us-east-1"
  gw_name                      = "aws-us-east-1-firenet-lab-1"
  cidr                         = "10.12.1.0/24"
  account                      = "aws-demo"
  insane_mode                  = true
  single_az_ha                 = false
  enable_encrypt_volume        = true
  learned_cidrs_approval_mode  = "connection"
  local_as_number              = "65021"
  bgp_ecmp                     = true
  enable_transit_firenet       = true
  enable_gateway_load_balancer = true
  enable_segmentation          = false
  bgp_polling_time             = "10"
  bgp_hold_time                = "12"
  ha_gw                        = false
  depends_on = [ aviatrix_account.aws_demo ]
}


module "transit_firenet_azure_1" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.6.0"

  cloud                       = "azure"
  region                      = "East US"
  gw_name                     = "az-east-us-firenet-lab-1"
  cidr                        = "10.12.2.0/24"
  account                     = "azure-demo"
  insane_mode                 = true
  single_az_ha                = false
  learned_cidrs_approval_mode = "connection"
  local_as_number             = "65022"
  bgp_ecmp                    = true
  enable_transit_firenet      = true
  enable_segmentation         = false
  bgp_polling_time            = "10"
  bgp_hold_time               = "12"
  ha_gw                       = false
  enable_bgp_over_lan         = true
  bgp_lan_interfaces_count    = 1
}

# module "transit_firenet_aws_2" {
#   source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
#   version = "2.6.0"
#
#   cloud                        = "aws"
#   region                       = "us-east-1"
#   gw_name                      = "aws-us-east-1-firenet-lab-2"
#   cidr                         = "10.12.3.0/24"
#   account                      = "aws-demo"
#   insane_mode                  = true
#   single_az_ha                 = false
#   enable_encrypt_volume        = true
#   learned_cidrs_approval_mode  = "connection"
#   local_as_number              = "65023"
#   bgp_ecmp                     = true
#   enable_transit_firenet       = true
#   enable_gateway_load_balancer = true
#   enable_segmentation          = false
#   bgp_polling_time             = "10"
#   bgp_hold_time                = "12"
#   ha_gw                        = false
# depends_on = [ aviatrix_account.aws_demo ]
# }

# module "transit_firenet_azure_2" {
#   source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
#   version = "2.6.0"
#
#   cloud                       = "azure"
#   region                      = "East US"
#   gw_name                     = "az-east-us-firenet-lab-2"
#   cidr                        = "10.12.4.0/24"
#   account                     = "azure-demo"
#   insane_mode                 = true
#   single_az_ha                = false
#   learned_cidrs_approval_mode = "connection"
#   local_as_number             = "65214"
#   bgp_ecmp                    = true
#   enable_transit_firenet      = true
#   enable_segmentation         = false
#   bgp_polling_time            = "10"
#   bgp_hold_time               = "12"
#   ha_gw                       = false
# }


module "transit-peering-firenet" {
  depends_on = [
    module.transit_firenet_azure_1, module.transit_firenet_aws_1,
    # module.transit_firenet_azure_2, module.transit_firenet_aws_2
  ]
  source = "./modules/aviatrix-mc-transit-peering-v2"

  custom_excluded_cidrs = []
  excluded_cidrs = ["0.0.0.0/0"]
  prepending = []
  transit_gateways_with_local_as = {
    "aws-us-east-1-firenet-lab-1" : 65021,
    # "aws-us-east-1-firenet-lab-2" : 65023,
    "az-east-us-firenet-lab-1" : 65022,
    # "az-east-us-firenet-lab-2" : 65024
  }
}
