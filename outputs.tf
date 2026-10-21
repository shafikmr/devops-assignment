
output "instance_ids" {
  description = "Map of instance name to EC2 instance ID"
  value       = module.ec2_instances.instance_ids
}

output "private_ips" {
  description = "Map of instance name to private IP address"
  value       = module.ec2_instances.private_ips
}
