provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAUHBWM3GPAV6IILOO"
  secret_key = "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"

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.37.0"
    }
  }
}
