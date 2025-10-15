terraform {
  required_version = ">=1.3.0"

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">= 5.0"        

    }
  }
}
provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_s3_bucket" "tf_state" {
    bucket = "my-terraform-state-bucket-787"

    lifecycle {
      prevent_destroy = true
    }

    object_lock_enabled = true

}



resource "aws_s3_bucket_versioning" "versioning" {

    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

bucket = aws_s3_bucket.tf_state.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }  
}

output "s3_bucket_name" {
    value = aws_s3_bucket.tf_state.bucket
}