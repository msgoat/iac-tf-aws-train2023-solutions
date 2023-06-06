region_name       = "eu-central-1"
organization_name = "msg"
department_name   = "BrAM AT2"
solution_name     = "cloudtrain"
solution_stage    = "dev"
solution_fqn      = "cloudtrain-dev"
network_name      = "train202302uck8s"
network_cidr      = "10.31.0.0/16"
inbound_traffic_cidrs = [ "0.0.0.0/0" ]
nat_strategy = "NAT_GATEWAY_SINGLE"
kubernetes_version = "1.24"
kubernetes_cluster_name = "train202302uck8s"
zones_to_span = 3
node_group_templates = [
  {
    enabled = true
    name = "appsblue"
    kubernetes_version = ""
    min_size = 1
    max_size = 4
    desired_size = 1
    disk_size = 100
    capacity_type = "SPOT"
    instance_types = [ "t3a.xlarge" ]
    labels = {}
    taints = []
  },
  {
    enabled = false
    name = "appsgreen"
    kubernetes_version = ""
    min_size = 1
    max_size = 4
    desired_size = 1
    disk_size = 100
    capacity_type = "SPOT"
    instance_types = [ "t3a.xlarge" ]
    labels = {}
    taints = []
  },
  {
    enabled = true
    name = "toolsblue"
    kubernetes_version = ""
    min_size = 1
    max_size = 4
    desired_size = 1
    disk_size = 100
    capacity_type = "SPOT"
    instance_types = [ "t3a.xlarge" ]
    labels = {}
    taints = [{
      key = "group.msg/workload"
      value = "tools"
      effect = "NO_SCHEDULE"
    }]
  }
]
