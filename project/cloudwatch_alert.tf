resource "aws_cloudwatch_metric_alarm" "resource_idle" {
  alarm_name                = "resource_idle_ec2"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 50
  alarm_description         = "This metric monitors ec2 cpu resource underutlization"
  insufficient_data_actions = []
}

resource "aws_sns_topic" "cloud_watch_alarm_topic" {
  name         = "cloud-watch-CPUUtilization-idle-alarm-topic"
  display_name = "CW Alarm CPUUtilization idle"
  tags         = local.tags
}

resource "aws_sns_topic_subscription" "cloud_watch_alarm_email_target" {
  topic_arn = aws_sns_topic.cloud_watch_alarm_topic.arn
  protocol  = "email"
  endpoint  = "ravikumar@pocketlaw.com" 
} 