data "openstack_images_image_v2" "os_image" {
  name = "Rocky 8.5"
}

# create instance based on count
resource "openstack_compute_instance_v2" "compute_instance" {
  count           = 1
  name            = "ESG WP4 Galaxy compute instance ${count.index}"
  flavor_name     = "m1.xxlarge"
  key_pair        = "cloud2"
  security_groups = ["default", "ufr-ingress"]

  network {
    name = "public"
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.os_image.id
    source_type           = "image"
    volume_size           = 20
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
    ssh_authorized_keys:
     - "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAA6oD5Ps9h6pKokzaAcCI6R08CKm2aSVv86h/O2HTEQkzeJq/Uvu4gbrONAM0FK5R693mHggIwaROKf1Z1+q4YNtACtYjV1c+6a9lcrGMM31y5RzO6mAW+rHNEXgZ1n3wqDcBQhSXhSekSen0R2QKwvmB7xeP4XX9qE10azZuafIFU9hQ== sanjay"
  EOF
}
