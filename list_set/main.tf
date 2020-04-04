# declare variable
variable "names" {
  default = ["jason","tom", "jack", "chris"]
  # default = ["tom", "jack", "tonny"]
  # type = string #any(預設) or number, boolen, list, map
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"
  version = "~> 2.55"
}

resource "aws_iam_user" "my_iam_user" {
  # count = length(var.names)
  # name  = var.names[count.index]
  for_each = toset(var.names)
  name = each.value
}
