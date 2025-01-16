output "transit_firenet_aws_1_vpc_id" {
  value = module.transit_firenet_aws_1.vpc.vpc_id
}

output "transit_firenet_aws_1_gw_name" {
  value = module.transit_firenet_aws_1.transit_gateway.gw_name
}

output "transit_firenet_azure_1_vpc_id" {
  value = module.transit_firenet_azure_1.vpc.vpc_id
}

output "transit_firenet_azure_1_gw_name" {
  value = module.transit_firenet_azure_1.transit_gateway.gw_name
}

# output "transit_firenet_aws_2_vpc_id" {
#   value = module.transit_firenet_aws_2.vpc.vpc_id
# }
#
# output "transit_firenet_aws_2_gw_name" {
#   value = module.transit_firenet_aws_2.transit_gateway.gw_name
# }
#
# output "transit_firenet_azure_2_vpc_id" {
#   value = module.transit_firenet_azure_2.vpc.vpc_id
# }
#
# output "transit_firenet_azure_2_gw_name" {
#   value = module.transit_firenet_azure_2.transit_gateway.gw_name
# }
