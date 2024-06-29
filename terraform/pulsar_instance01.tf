# create instance based on count
resource "openstack_compute_instance_v2" "pulsar_instance01" {
  name            = "ESG_Galaxy_Pulsar_instance01"
  flavor_name     = "m1.xxlarge"
  key_pair        = "esg-sanjay-keypair"
  security_groups = ["default", "esg-public-ssh"]

  network {
    name = "public-extended"
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.os_image.id
    source_type           = "image"
    volume_size           = 30
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  user_data = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: true
    users:
     - default
  EOF
}
