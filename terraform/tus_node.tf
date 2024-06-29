data "openstack_images_image_v2" "rustus_os_image" {
  name = "Rocky 9.3"
}

resource "openstack_compute_instance_v2" "rustus_instance" {
  name            = "ESG_Galaxy_Rustus_instance"
  flavor_name     = "m1.medium"
  key_pair        = "esg-sanjay-keypair"
  security_groups = ["default", "esg-public-ssh", "esg-public-web"]

  network {
    name = "public-extended"
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.rustus_os_image.id
    source_type           = "image"
    volume_size           = 25
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