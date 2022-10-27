# Aws HPC Cluster instances - terraform

Create three aws HPC cluster node EC2 instances by using [terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), base on this [hosts file](https://github.com/yjun-001/multi-aws-instances/blob/f5afca22f5b18cb27f1be86189f0d34767730d49/hosts.ini)
https://github.com/yjun-001/multi-aws-instances/blob/f5afca22f5b18cb27f1be86189f0d34767730d49/hosts.ini#L1-L14


### Prerequisite Package and its environment Setup (Windows 10 Desktop)
- Install Windows WSL2 & Ubuntu from Microsoft Store
- Install awscli inside WSL
  - sudo apt install aws
- Install [terraform](https://www.terraform.io/downloads)
  - download **terraform** linux binary and unzip it and move into /usr/local/bin
 
### Reposity Usage:
- Clone [this repositry](https://github.com/yjun-001/multi-aws-instances.git)
- following commands are available:
    - **terraform init**
    - **terraform plan**
    - **terraform graph --draw-cycle**
    - **terraform apply**
      - multiple aws instances should be created by applying successfully
    - **terraform destroy**

### terraform graph
![Alt text](https://github.com/yjun-001/multi-aws-instances/image/graphviz.svg)
<img src=https://github.com/yjun-001/multi-aws-instances/image/graphviz.svg>

### This repoistory will do 
- create an AWS VPC with cidr_block = "10.0.0.0/16"
- create an AWS Public subnet  with cidr_block = 10.0.1.0/24" # 254 IP addresses available in this subnet
- create an AWS Internat Gateway(IG) and route table (RT)
- create an AWS Security Group (SG), and allow ssh incoming traffic at port 22
- create a three nodes of EC2 cluster instances, 
  - assign each instances a static private IP. this IP address is the primary address of private subnet, instead of the default assigned DHCP address, [DHCP Issues](https://stackoverflow.com/questions/42666396/terraform-correctly-assigning-a-static-private-ip-to-newly-created-instance)
  - setup each hostname according to hosts file.
  - update private in master node instance, so i can ssh other nodes without password

### Code in Action and its Output:
#### **terraform apply:**
```bash
>terraform apply
data.external.datasource_host_2_ip: Reading...
data.external.datasource_host_2_ip: Read complete after 1s [id=-]

Terraform used the selected providers to generate the following execution plan. Resource actions
are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.hpc_aws_instance["master"] will be created
  + resource "aws_instance" "hpc_aws_instance" {
      + ami                                  = "ami-0d5bf08bc8017c83b"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "aws_hpc_keypair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance master"
          + "OS"          = "Ubuntu 20.04"
        }
      + tags_all                             = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance master"
          + "OS"          = "Ubuntu 20.04"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id                 = (known after apply)
              + capacity_reservation_resource_group_arn = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + maintenance_options {
          + auto_recovery = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_card_index    = 0
          + network_interface_id  = (known after apply)
        }

      + private_dns_name_options {
          + enable_resource_name_dns_a_record    = (known after apply)
          + enable_resource_name_dns_aaaa_record = (known after apply)
          + hostname_type                        = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.hpc_aws_instance["node1"] will be created
  + resource "aws_instance" "hpc_aws_instance" {
      + ami                                  = "ami-0d5bf08bc8017c83b"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "aws_hpc_keypair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance node1"
          + "OS"          = "Ubuntu 20.04"
        }
      + tags_all                             = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance node1"
          + "OS"          = "Ubuntu 20.04"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id                 = (known after apply)
              + capacity_reservation_resource_group_arn = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + maintenance_options {
          + auto_recovery = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_card_index    = 0
          + network_interface_id  = (known after apply)
        }

      + private_dns_name_options {
          + enable_resource_name_dns_a_record    = (known after apply)
          + enable_resource_name_dns_aaaa_record = (known after apply)
          + hostname_type                        = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.hpc_aws_instance["node2"] will be created
  + resource "aws_instance" "hpc_aws_instance" {
      + ami                                  = "ami-0d5bf08bc8017c83b"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "aws_hpc_keypair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance node2"
          + "OS"          = "Ubuntu 20.04"
        }
      + tags_all                             = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC E2 instance node2"
          + "OS"          = "Ubuntu 20.04"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id                 = (known after apply)
              + capacity_reservation_resource_group_arn = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + maintenance_options {
          + auto_recovery = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_card_index    = 0
          + network_interface_id  = (known after apply)
        }

      + private_dns_name_options {
          + enable_resource_name_dns_a_record    = (known after apply)
          + enable_resource_name_dns_aaaa_record = (known after apply)
          + hostname_type                        = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.hpc_igw will be created
  + resource "aws_internet_gateway" "hpc_igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "hpc-igw"
        }
      + tags_all = {
          + "Name" = "hpc-igw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_network_interface.hpc_interface["master"] will be created
  + resource "aws_network_interface" "hpc_interface" {
      + arn                       = (known after apply)
      + id                        = (known after apply)
      + interface_type            = (known after apply)
      + ipv4_prefix_count         = (known after apply)
      + ipv4_prefixes             = (known after apply)
      + ipv6_address_count        = (known after apply)
      + ipv6_address_list         = (known after apply)
      + ipv6_address_list_enabled = false
      + ipv6_addresses            = (known after apply)
      + ipv6_prefix_count         = (known after apply)
      + ipv6_prefixes             = (known after apply)
      + mac_address               = (known after apply)
      + outpost_arn               = (known after apply)
      + owner_id                  = (known after apply)
      + private_dns_name          = (known after apply)
      + private_ip                = (known after apply)
      + private_ip_list           = (known after apply)
      + private_ip_list_enabled   = false
      + private_ips               = [
          + "10.0.1.100",
        ]
      + private_ips_count         = (known after apply)
      + security_groups           = (known after apply)
      + source_dest_check         = true
      + subnet_id                 = (known after apply)
      + tags_all                  = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_network_interface.hpc_interface["node1"] will be created
  + resource "aws_network_interface" "hpc_interface" {
      + arn                       = (known after apply)
      + id                        = (known after apply)
      + interface_type            = (known after apply)
      + ipv4_prefix_count         = (known after apply)
      + ipv4_prefixes             = (known after apply)
      + ipv6_address_count        = (known after apply)
      + ipv6_address_list         = (known after apply)
      + ipv6_address_list_enabled = false
      + ipv6_addresses            = (known after apply)
      + ipv6_prefix_count         = (known after apply)
      + ipv6_prefixes             = (known after apply)
      + mac_address               = (known after apply)
      + outpost_arn               = (known after apply)
      + owner_id                  = (known after apply)
      + private_dns_name          = (known after apply)
      + private_ip                = (known after apply)
      + private_ip_list           = (known after apply)
      + private_ip_list_enabled   = false
      + private_ips               = [
          + "10.0.1.101",
        ]
      + private_ips_count         = (known after apply)
      + security_groups           = (known after apply)
      + source_dest_check         = true
      + subnet_id                 = (known after apply)
      + tags_all                  = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_network_interface.hpc_interface["node2"] will be created
  + resource "aws_network_interface" "hpc_interface" {
      + arn                       = (known after apply)
      + id                        = (known after apply)
      + interface_type            = (known after apply)
      + ipv4_prefix_count         = (known after apply)
      + ipv4_prefixes             = (known after apply)
      + ipv6_address_count        = (known after apply)
      + ipv6_address_list         = (known after apply)
      + ipv6_address_list_enabled = false
      + ipv6_addresses            = (known after apply)
      + ipv6_prefix_count         = (known after apply)
      + ipv6_prefixes             = (known after apply)
      + mac_address               = (known after apply)
      + outpost_arn               = (known after apply)
      + owner_id                  = (known after apply)
      + private_dns_name          = (known after apply)
      + private_ip                = (known after apply)
      + private_ip_list           = (known after apply)
      + private_ip_list_enabled   = false
      + private_ips               = [
          + "10.0.1.102",
        ]
      + private_ips_count         = (known after apply)
      + security_groups           = (known after apply)
      + source_dest_check         = true
      + subnet_id                 = (known after apply)
      + tags_all                  = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_route_table.hpc_public_route_table will be created
  + resource "aws_route_table" "hpc_public_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "hpc-public-route-table"
        }
      + tags_all         = {
          + "Name" = "hpc-public-route-table"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.hpc_route_table_public_subnet-1 will be created
  + resource "aws_route_table_association" "hpc_route_table_public_subnet-1" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.allow_ssh_sg will be created
  + resource "aws_security_group" "allow_ssh_sg" {
      + arn                    = (known after apply)
      + description            = "allow ssh inbond traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "name" = "allowed_ssh"
        }
      + tags_all               = {
          + "name" = "allowed_ssh"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.hpc_subnet will be created
  + resource "aws_subnet" "hpc_subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "hpc_subnet"
        }
      + tags_all                                       = {
          + "Name" = "hpc_subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.hpc_vpc will be created
  + resource "aws_vpc" "hpc_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "hpc_vpc"
        }
      + tags_all                             = {
          + "Name" = "hpc_vpc"
        }
    }

Plan: 12 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aws_hpc_instance         = {
      + master = (known after apply)
      + node1  = (known after apply)
      + node2  = (known after apply)
    }
  + datasource_host_2_ip_out = [
      + "master",
      + "node1",
      + "node2",
    ]
  + local_host_2_ip_out      = [
      + "master",
      + "node1",
      + "node2",
    ]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.hpc_vpc: Creating...
aws_vpc.hpc_vpc: Still creating... [10s elapsed]
aws_vpc.hpc_vpc: Creation complete after 13s [id=vpc-0d33d327227ffc151]
aws_internet_gateway.hpc_igw: Creating...
aws_subnet.hpc_subnet: Creating...
aws_security_group.allow_ssh_sg: Creating...
aws_internet_gateway.hpc_igw: Creation complete after 0s [id=igw-04fde5f242cd377cf]
aws_route_table.hpc_public_route_table: Creating...
aws_route_table.hpc_public_route_table: Creation complete after 1s [id=rtb-0db55a6779e9efb74]
aws_security_group.allow_ssh_sg: Creation complete after 2s [id=sg-0bc9ad9a6c1da73fe]
aws_subnet.hpc_subnet: Still creating... [10s elapsed]
aws_subnet.hpc_subnet: Creation complete after 11s [id=subnet-0ab8e46f9cafc58f1]
aws_route_table_association.hpc_route_table_public_subnet-1: Creating...
aws_network_interface.hpc_interface["node2"]: Creating...
aws_network_interface.hpc_interface["node1"]: Creating...
aws_network_interface.hpc_interface["master"]: Creating...
aws_route_table_association.hpc_route_table_public_subnet-1: Creation complete after 0s [id=rtbassoc-033724906dce93da1]
aws_network_interface.hpc_interface["node1"]: Creation complete after 0s [id=eni-0ac0cde23becaa6b6]
aws_network_interface.hpc_interface["node2"]: Creation complete after 0s [id=eni-07120539c45cb0f29]
aws_network_interface.hpc_interface["master"]: Creation complete after 0s [id=eni-0f8a96eace7e427de]aws_instance.hpc_aws_instance["node2"]: Creating...
aws_instance.hpc_aws_instance["master"]: Creating...
aws_instance.hpc_aws_instance["node1"]: Creating...
aws_instance.hpc_aws_instance["node2"]: Still creating... [10s elapsed]
aws_instance.hpc_aws_instance["master"]: Still creating... [10s elapsed]
aws_instance.hpc_aws_instance["node1"]: Still creating... [10s elapsed]
aws_instance.hpc_aws_instance["node2"]: Still creating... [20s elapsed]
aws_instance.hpc_aws_instance["master"]: Still creating... [20s elapsed]
aws_instance.hpc_aws_instance["node1"]: Still creating... [20s elapsed]
aws_instance.hpc_aws_instance["master"]: Provisioning with 'local-exec'...
aws_instance.hpc_aws_instance["master"] (local-exec): Executing: ["/bin/sh" "-c" "echo \"The server's IP address is 10.0.1.100\""]
aws_instance.hpc_aws_instance["master"] (local-exec): The server's IP address is 10.0.1.100
aws_instance.hpc_aws_instance["master"]: Provisioning with 'remote-exec'...
aws_instance.hpc_aws_instance["master"] (remote-exec): Connecting to remote host via SSH...
aws_instance.hpc_aws_instance["master"] (remote-exec):   Host: 3.19.239.84
aws_instance.hpc_aws_instance["master"] (remote-exec):   User: ubuntu
aws_instance.hpc_aws_instance["master"] (remote-exec):   Password: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Private key: true
aws_instance.hpc_aws_instance["master"] (remote-exec):   Certificate: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   SSH Agent: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Checking Host Key: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Target Platform: unix
aws_instance.hpc_aws_instance["node1"]: Still creating... [30s elapsed]
aws_instance.hpc_aws_instance["master"]: Still creating... [30s elapsed]
aws_instance.hpc_aws_instance["node2"]: Still creating... [30s elapsed]
aws_instance.hpc_aws_instance["master"] (remote-exec): Connecting to remote host via SSH...
aws_instance.hpc_aws_instance["master"] (remote-exec):   Host: 3.19.239.84
aws_instance.hpc_aws_instance["master"] (remote-exec):   User: ubuntu
aws_instance.hpc_aws_instance["master"] (remote-exec):   Password: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Private key: true
aws_instance.hpc_aws_instance["master"] (remote-exec):   Certificate: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   SSH Agent: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Checking Host Key: false
aws_instance.hpc_aws_instance["master"] (remote-exec):   Target Platform: unix
aws_instance.hpc_aws_instance["master"] (remote-exec): Connected!
aws_instance.hpc_aws_instance["node1"]: Provisioning with 'local-exec'...
aws_instance.hpc_aws_instance["node1"] (local-exec): Executing: ["/bin/sh" "-c" "echo \"The server's IP address is 10.0.1.101\""]
aws_instance.hpc_aws_instance["node1"] (local-exec): The server's IP address is 10.0.1.101
aws_instance.hpc_aws_instance["node1"]: Provisioning with 'remote-exec'...
aws_instance.hpc_aws_instance["node1"] (remote-exec): Connecting to remote host via SSH...
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Host: 18.223.156.139
aws_instance.hpc_aws_instance["node1"] (remote-exec):   User: ubuntu
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Password: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Private key: true
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Certificate: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   SSH Agent: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Checking Host Key: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Target Platform: unix
aws_instance.hpc_aws_instance["node2"]: Provisioning with 'local-exec'...
aws_instance.hpc_aws_instance["node2"] (local-exec): Executing: ["/bin/sh" "-c" "echo \"The server's IP address is 10.0.1.102\""]
aws_instance.hpc_aws_instance["node2"] (local-exec): The server's IP address is 10.0.1.102
aws_instance.hpc_aws_instance["node2"]: Provisioning with 'remote-exec'...
aws_instance.hpc_aws_instance["node2"] (remote-exec): Connecting to remote host via SSH...
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Host: 3.23.115.226
aws_instance.hpc_aws_instance["node2"] (remote-exec):   User: ubuntu
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Password: false
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Private key: true
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Certificate: false
aws_instance.hpc_aws_instance["node2"] (remote-exec):   SSH Agent: false
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Checking Host Key: false
aws_instance.hpc_aws_instance["node2"] (remote-exec):   Target Platform: unix
aws_instance.hpc_aws_instance["node2"] (remote-exec): Connected!
aws_instance.hpc_aws_instance["master"]: Creation complete after 34s [id=i-0cd16d632dbf013d4]
aws_instance.hpc_aws_instance["node1"] (remote-exec): Connecting to remote host via SSH...
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Host: 18.223.156.139
aws_instance.hpc_aws_instance["node1"] (remote-exec):   User: ubuntu
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Password: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Private key: true
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Certificate: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   SSH Agent: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Checking Host Key: false
aws_instance.hpc_aws_instance["node1"] (remote-exec):   Target Platform: unix
aws_instance.hpc_aws_instance["node2"]: Creation complete after 37s [id=i-0ea3c93e2a529ee5d]
aws_instance.hpc_aws_instance["node1"] (remote-exec): Connected!
aws_instance.hpc_aws_instance["node1"]: Still creating... [40s elapsed]
aws_instance.hpc_aws_instance["node1"]: Creation complete after 43s [id=i-0542ae073d726c7d1]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

aws_hpc_instance = {
  "master" = "3.19.239.84"
  "node1" = "18.223.156.139"
  "node2" = "3.23.115.226"
}
datasource_host_2_ip_out = tolist([
  "master",
  "node1",
  "node2",
])
local_host_2_ip_out = [
  "master",
  "node1",
  "node2",
]
```


Destroy complete! Resources: 2 destroyed.
```
