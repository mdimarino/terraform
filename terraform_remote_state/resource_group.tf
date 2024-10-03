resource "aws_resourcegroups_group" "resource_group_terraform_remote_state" {
  name        = local.name
  description = "Grupo de recursos ${local.name}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "ResourceGroup",
      "Values": ["${local.name}"]
    }
  ]
}
JSON
  }

  tags = {
    Name = "${local.name}"
  }
}
