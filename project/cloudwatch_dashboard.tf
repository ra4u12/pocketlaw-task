resource "aws_cloudwatch_dashboard" "ec2" {
  dashboard_name = "cloudwatch-ec2-dashboard"
  
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization"
          ]
        ],
        "period": 5,
        "stat": "Maximum",
        "region": "us-east-2",
        "title": "EC2|CPU Utilization"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkIn"
          ]
        ],
        "period": 5,
        "stat": "Maximum",
        "region": "us-east-2",
        "title": "EC2|Network In"
      }
    },
    {
      "type": "metric",
      "x": 16,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkOut"
          ]
        ],
        "period": 5,
        "stat": "Maximum",
        "region": "us-east-2",
        "title": "EC2|Network Out"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "DiskReadOps"
          ]
        ],
        "period": 5,
        "stat": "Maximum",
        "region": "us-east-2",
        "title": "EC2|Disk Read Ops"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "DiskWriteOps"
          ]
        ],
        "period": 5,
        "stat": "Maximum",
        "region": "us-east-2",
        "title": "EC2|Disk Write Ops"
      }
    }
   ]
 } 
 EOF

}