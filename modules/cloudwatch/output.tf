output "alarm_name" {
  description = "Name of the CloudWatch CPU alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu.alarm_name
}

output "alarm_arn" {
  description = "ARN of the CloudWatch CPU alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu.arn
}