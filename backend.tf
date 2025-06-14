terraform {
  backend "s3" {
    bucket = "3igrik-rs-tf-state-2025"
    key    = "terraform.tfstate"            
    region = "eu-north-1"                    
    encrypt = true                          
    dynamodb_table = "terraform-state-lock"
  }
}