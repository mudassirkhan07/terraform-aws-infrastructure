resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name          = "assignment-ec2-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = 120
  statistic   = "Average"
  threshold   = 80

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_description         = "This alarm monitors EC2 CPU utilization"
  insufficient_data_actions = []
}