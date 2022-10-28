# The first way: import host data

locals { # this code to parse hosts.ini file to get a map of host and its ip
  raw_lines = [
    for line in compact(split("\n", file("${path.module}/hosts.ini"))) :
    line if length(split(" ", line)) > 1 &&
    length(regexall("^#", line)) == 0
    #line
  ]
  lines = [ # leave interesting only line to further parsing
    for line in local.raw_lines :
    compact(split(" ", line))
  ]
  local_host_2_ip = {
    for rec in local.lines :
    rec[0] => split("=", rec[1])[1]
  }
  # output as string of host_2_ip
  string_local_host_2_ip = join(",", formatlist("%s:%s",
  keys(local.local_host_2_ip), values(local.local_host_2_ip)))
}

output "local_host_2_ip_out" {
  value = keys(local.local_host_2_ip)
}

# The second way: import host data
data "external" "datasource_host_2_ip" {
  program = [
    "bash",
    "${path.module}/paser.sh",
    "${path.module}/hosts.ini",
    ""
  ]
}

locals {
  datasource_host_2_ip = data.external.datasource_host_2_ip.result
}

output "datasource_host_2_ip_out" {
  value = keys(local.datasource_host_2_ip)
}

variable "PRIVATE_KEY_PATH" {
  type    = string
  default = "~/projs/aws_hpc_keypair.pem"
}

locals {
  provision_commands = {
    "nodes" : [
      "echo \"Nodes provisioning:\"",
      "[ -f ~/.ssh/id_rsa ] && rm -f ~/.ssh/id_rsa"
    ],
    "master" : [
      "echo \"Master node provisioning:\"",
      "[ -f ~/.ssh/id_rsa ] && chmod 600 ~/.ssh/id_rsa"
    ],
  }
}