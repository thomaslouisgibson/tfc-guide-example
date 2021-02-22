provider "aws" {
  region = var.aws_region
}

provider "random" {}

resource "random_pet" "table_name" {}


resource "aws_iam_service_linked_role" "elasticbeanstalk" {
  aws_service_name = "elasticbeanstalk.amazonaws.com"
}

resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-desc"

  appversion_lifecycle {
    service_role          = aws_iam_service_linked_role.elasticbeanstalk.arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}
