# tf config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
}

# resources
module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "leaderboard"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "PK"
  range_key = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  attribute {
    name = "Data"
    type = "S"
  }

  ttl {
    enabled        = false
    attribute_name = "TTL"
  }

  global_secondary_index {
    name               = "GSI1"
    hash_key           = "SK"
    range_key          = "PK"
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "GSI2"
    hash_key           = "SK"
    range_key          = "Data"
    projection_type    = "ALL"
  }

  tags = {
    Terraform   = "true"
    Environment = "development"
  }

}
