# public SSH
resource "openstack_networking_secgroup_v2" "public_ssh" {
  name        = "esg-public-ssh"
  description = "Allow SSH from the public network"
}

resource "openstack_networking_secgroup_rule_v2" "public_ssh_ingress" {
  security_group_id = openstack_networking_secgroup_v2.public_ssh.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
}

# Public Web
resource "openstack_networking_secgroup_v2" "public_web" {
  name        = "esg-public-web"
  description = "Allow HTTP and HTTPS from the public network"
}

resource "openstack_networking_secgroup_rule_v2" "public_web_ingress_http" {
  security_group_id = openstack_networking_secgroup_v2.public_web.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "public_web_ingress_https" {
  security_group_id = openstack_networking_secgroup_v2.public_web.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
}

# MQ
resource "openstack_networking_secgroup_v2" "public_amqp" {
  name        = "esg-public-amqp"
  description = "Allow AMQP from the public network"
}

resource "openstack_networking_secgroup_rule_v2" "public_amqp_ingress" {
  security_group_id = openstack_networking_secgroup_v2.public_amqp.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5671
  port_range_max    = 5671
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "public_amqp_redis_ingress" {
  security_group_id = openstack_networking_secgroup_v2.public_amqp.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6379
  port_range_max    = 6379
  remote_ip_prefix  = "0.0.0.0/0"
}
