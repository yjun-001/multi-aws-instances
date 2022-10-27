# Aws HPC Cluster instances - terraform

Create three aws HPC cluster node EC2 instances by using [terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), base on hosts file


### Prerequisite Package and its environment Setup (Windows 10 Desktop)
- Install Windows WSL2 & Ubuntu from Microsoft Store
- Install awscli inside WSL
  - sudo apt install aws
- Install [terraform](https://www.terraform.io/downloads)
  - download **terraform** linux binary and unzip it and move into /usr/local/bin
 
### Reposity Usage:
- Clone [this repositry](https://github.com/yjun-001/terraform_aws_instance.git)
- following commands are available:
    - **terraform init**
    - **terraform plan**
    - **terraform apply**
      - one aws instance should be created by applying successfully
    - **terraform destroy**


### Objects
- create a number of EC2 instances and assign them each a static private ip address from a map variable. This address must be the primary address, instead of the default assigned DHCP address, [DHCP Issues](https://stackoverflow.com/questions/42666396/terraform-correctly-assigning-a-static-private-ip-to-newly-created-instance)

### Code Action and its Output:
#### **terraform apply:**
```bash
>terraform apply
aws_security_group.allow_ssh_sg: Refreshing state... [id=sg-02cfa9700f8bd8c9a]

Terraform used the selected providers to generate the following execution plan. Resource actions
are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.aws_hpc_instance will be created
  + resource "aws_instance" "aws_hpc_instance" {
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
      + security_groups                      = [
          + "allow_ssh",
        ]
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC aws instance"
          + "OS"          = "Ubuntu 20.04"
        }
      + tags_all                             = {
          + "Environment" = "Sandbox"
          + "Managed"     = "IaC"
          + "Name"        = "HPC aws instance"
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
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_card_index    = (known after apply)
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

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ aws_hpc_instance = "ec2-52-15-144-177.us-east-2.compute.amazonaws.com" -> (known after apply)  

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.aws_hpc_instance: Creating...
aws_instance.aws_hpc_instance: Still creating... [10s elapsed]
aws_instance.aws_hpc_instance: Still creating... [20s elapsed]
aws_instance.aws_hpc_instance: Still creating... [30s elapsed]
aws_instance.aws_hpc_instance: Creation complete after 32s [id=i-085892a3ba0569d1d]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

aws_hpc_instance = "18.222.105.68"
```
#### **ssh to the aws hpc instance**:
```bash
>ssh -i ../../aws_hpc_keypair.pem  ubuntu@18.222.105.68
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.15.0-1019-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Oct 24 19:00:55 UTC 2022

  System load:  0.05              Processes:             102
  Usage of /:   19.6% of 7.57GB   Users logged in:       0
  Memory usage: 21%               IPv4 address for eth0: 172.31.35.241
  Swap usage:   0%

0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
top - 19:01:21 up 3 min,  1 user,  load average: 0.03, 0.09, 0.04
Tasks: 102 total,   1 running, 101 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.3 sy,  0.0 ni, 99.3 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    966.2 total,    312.4 free,    186.7 used,    467.1 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    630.2 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                     
   1296 ubuntu    20   0   10876   3648   3160 R   0.3   0.4   0:00.02 top                         
      1 root      20   0  103692  12312   8144 S   0.0   1.2   0:04.53 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
ubuntu@ip-172-31-35-241:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.6G  1.6G  6.1G  20% /
devtmpfs        477M     0  477M   0% /dev
tmpfs           484M     0  484M   0% /dev/shm
tmpfs            97M  832K   96M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           484M     0  484M   0% /sys/fs/cgroup
/dev/loop1       56M   56M     0 100% /snap/core18/2566
/dev/loop0       26M   26M     0 100% /snap/amazon-ssm-agent/5656
/dev/loop3       68M   68M     0 100% /snap/lxd/22753
/dev/loop2       64M   64M     0 100% /snap/core20/1623
/dev/loop4       48M   48M     0 100% /snap/snapd/16778
/dev/xvda15     105M  5.2M  100M   5% /boot/efi
tmpfs            97M     0   97M   0% /run/user/1000
```

#### **terraform destory**:
```bash
>terraform destroy
aws_security_group.allow_ssh_sg: Refreshing state... [id=sg-02cfa9700f8bd8c9a]
aws_instance.aws_hpc_instance: Refreshing state... [id=i-085892a3ba0569d1d]

Terraform used the selected providers to generate the following execution plan. Resource actions
are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.aws_hpc_instance will be destroyed
  - resource "aws_instance" "aws_hpc_instance" {
      - ami                                  = "ami-0d5bf08bc8017c83b" -> null
      - arn                                  = "arn:aws:ec2:us-east-2:180775276220:instance/i-085892a3ba0569d1d" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "us-east-2c" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 1 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-085892a3ba0569d1d" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t2.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - key_name                             = "aws_hpc_keypair" -> null
      - monitoring                           = false -> null
      - primary_network_interface_id         = "eni-0ce1fdb80d82d58ed" -> null
      - private_dns                          = "ip-172-31-35-241.us-east-2.compute.internal" -> null
      - private_ip                           = "172.31.35.241" -> null
      - public_dns                           = "ec2-18-222-105-68.us-east-2.compute.amazonaws.com" 
-> null
      - public_ip                            = "18.222.105.68" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [
          - "allow_ssh",
        ] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-0f7c2f05b0959e938" -> null
      - tags                                 = {
          - "Environment" = "Sandbox"
          - "Managed"     = "IaC"
          - "Name"        = "HPC aws instance"
          - "OS"          = "Ubuntu 20.04"
        } -> null
      - tags_all                             = {
          - "Environment" = "Sandbox"
          - "Managed"     = "IaC"
          - "Name"        = "HPC aws instance"
          - "OS"          = "Ubuntu 20.04"
        } -> null
      - tenancy                              = "default" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-02cfa9700f8bd8c9a",
        ] -> null

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - tags                  = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-078b21ca488a4f326" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_security_group.allow_ssh_sg will be destroyed
  - resource "aws_security_group" "allow_ssh_sg" {
      - arn                    = "arn:aws:ec2:us-east-2:180775276220:security-group/sg-02cfa9700f8bd8c9a" -> null
      - description            = "allow ssh inbond traffic" -> null
      - egress                 = [] -> null
      - id                     = "sg-02cfa9700f8bd8c9a" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
        ] -> null
      - name                   = "allow_ssh" -> null
      - owner_id               = "180775276220" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {} -> null
      - tags_all               = {} -> null
      - vpc_id                 = "vpc-0f6d2d2c93e48ed29" -> null
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  - aws_hpc_instance = "18.222.105.68" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.aws_hpc_instance: Destroying... [id=i-085892a3ba0569d1d]
aws_instance.aws_hpc_instance: Still destroying... [id=i-085892a3ba0569d1d, 10s elapsed]
aws_instance.aws_hpc_instance: Still destroying... [id=i-085892a3ba0569d1d, 20s elapsed]
aws_instance.aws_hpc_instance: Destruction complete after 30s
aws_security_group.allow_ssh_sg: Destroying... [id=sg-02cfa9700f8bd8c9a]
aws_security_group.allow_ssh_sg: Destruction complete after 1s

Destroy complete! Resources: 2 destroyed.
```
