output "vpc_name" {
  description = "The name of the created VPC"
  value       = var.vpc_name
}

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id,
    aws_subnet.private_subnet_4.id
  ]
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "alb_dns_name" {
  value = aws_lb.public_alb.dns_name
}

output "tomcat_instance_ids" {
  value = aws_autoscaling_group.tomcat_asg.id
}

# output "internet_gateway" {
#   description = "The ID of the created Internet Gateway"
#   value       = aws_internet_gateway.main.id
# }

# output "nat_gateway" {
#   description = "The ID of the created NAT Gateway"
#   value       = aws_nat_gateway.main.id
# }
