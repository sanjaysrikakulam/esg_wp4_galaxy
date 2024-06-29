resource "openstack_compute_instance_v2" "galaxy_instance" {
  name            = "ESG_Galaxy_instance"
  flavor_name     = "m1.xlarge"
  key_pair        = "esg-sanjay-keypair"
  security_groups = ["default", "esg-public-ssh", "esg-public-web"]

  network {
    name = "public-extended"
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.os_image.id
    source_type           = "image"
    volume_size           = 300
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