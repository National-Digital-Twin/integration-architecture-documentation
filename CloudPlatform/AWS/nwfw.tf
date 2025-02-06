module "network_firewall" {
  source = "terraform-aws-modules/network-firewall/aws"

  name        = local.resource_prefix
  description = "${local.resource_prefix} Network firewall"

  delete_protection                 = false
  firewall_policy_change_protection = false
  subnet_change_protection          = false

  vpc_id = module.vpc.vpc_id
  subnet_mapping = {
    subnet1 = {
      subnet_id       = aws_subnet.nwfw[0].id
      ip_address_type = "IPV4"
    }
    subnet2 = {
      subnet_id       = aws_subnet.nwfw[1].id
      ip_address_type = "IPV4"
    }
    subnet3 = {
      subnet_id       = aws_subnet.nwfw[2].id
      ip_address_type = "IPV4"
    }
  }

  create_logging_configuration = false

  policy_name        = "${local.resource_prefix}-policy"
  policy_description = "${local.resource_prefix} network firewall policy"

  policy_stateful_rule_group_reference = {
    one = { resource_arn = module.network_firewall_rule_group_stateful.arn }
  }

  policy_stateless_default_actions          = ["aws:drop"]
  policy_stateless_fragment_default_actions = ["aws:drop"]
  policy_stateless_rule_group_reference = {
    one = {
      priority     = 1
      resource_arn = module.network_firewall_rule_group_stateless.arn
    }
  }
}

module "network_firewall_rule_group_stateless" {
  source = "terraform-aws-modules/network-firewall/aws//modules/rule-group"

  name        = "${local.resource_prefix}-stateless"
  description = "Stateless Inspection forward to stateful"
  type        = "STATELESS"
  capacity    = 100

  rule_group = {
    rules_source = {
      stateless_rules_and_custom_actions = {
        custom_action = [{
          action_definition = {
            publish_metric_action = {
              dimension = [{
                value = "2"
              }]
            }
          }
          action_name = "DefaultAction"
        }]
        stateless_rule = [{
          priority = 1
          rule_definition = {
            actions = ["aws:forward_to_sfe", "DefaultAction"]
            match_attributes = {
              source = [{
                address_definition = "0.0.0.0/0"
              }]
              destination = [{
                address_definition = "0.0.0.0/0"
              }]
            }
          }
        }]
      }
    }
  }

  # Resource Policy
  create_resource_policy     = true
  attach_resource_policy     = true
  resource_policy_principals = ["arn:aws:iam::${local.account_id}:root"]
}

module "network_firewall_rule_group_stateful" {
  source = "terraform-aws-modules/network-firewall/aws//modules/rule-group"

  name        = "${local.resource_prefix}-stateful"
  description = "Stateful Inspection for denying access to a domain"
  type        = "STATEFUL"
  capacity    = 100

  rule_group = {
    rules_source = {
      rules_source_list = {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["TLS_SNI"]
        targets              = ["cognito-idp.eu-west-2.amazonaws.com", "${local.resource_prefix}.auth.eu-west-2.amazoncognito.com"]
      }
    }
  }

  # Resource Policy
  create_resource_policy     = true
  attach_resource_policy     = true
  resource_policy_principals = ["arn:aws:iam::${local.account_id}:root"]
}
