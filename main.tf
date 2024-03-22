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

  ttl_attribute_name = "TTL"
  ttl_enabled        = false

  hash_key  = "PK"
  range_key = "SK"

  attributes = [
    {
      name = "PK"
      type = "S"
    },
    {
      name = "SK"
      type = "S"
    },
    {
      name = "Data"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "GSI1"
      hash_key           = "SK"
      range_key          = "PK"
      projection_type    = "ALL"
    },
    {
      name               = "GSI2"
      hash_key           = "SK"
      range_key          = "Data"
      projection_type    = "ALL"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "development"
  }

}
