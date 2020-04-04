
# declare variable
variable "users" {
  default = {
    tom : { country : "Taiwan", department : "ABC" }
    jack : { country : "UK", department : "EFG" },
    chris : { country : "US", department : "XYZ" },
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"
  version = "~> 2.55"
}

resource "aws_iam_user" "my_iam_user" {
  for_each = var.users
  name     = each.key
  tags = {
    # country :each.value
    country : each.value.country
    department : each.value.department
  }
}
