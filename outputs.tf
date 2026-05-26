output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the target group"
  value       = try(aws_lb_target_group.this[0].id, null)
}

output "arn" {
  description = "ARN of the target group"
  value       = try(aws_lb_target_group.this[0].arn, null)
}

output "arn_suffix" {
  description = "ARN suffix for CloudWatch metrics"
  value       = try(aws_lb_target_group.this[0].arn_suffix, null)
}

output "name" {
  description = "Name of the target group"
  value       = try(aws_lb_target_group.this[0].name, null)
}
