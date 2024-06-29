resource "openstack_compute_instance_v2" "nfs_instance" {
  name            = "ESG WP4 Galaxy NFS instance"
  flavor_name     = "m1.medium"
  key_pair        = "esg-sanjay-keypair"
  security_groups = ["default", "esg-public-ssh"]

  network {
    name = "public-extended"
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
  EOF
}

resource "openstack_blockstorage_volume_v3" "nfs_galaxy_data_volume" {
  name  = "esg_wp4_galaxy_nfs_share_data"
  size  = 80
}

resource "openstack_compute_volume_attach_v2" "_nfs_galaxy_data_va" {
  instance_id = openstack_compute_instance_v2.nfs_instance.id
  volume_id   = openstack_blockstorage_volume_v3.nfs_galaxy_data_volume.id
}

resource "openstack_blockstorage_volume_v3" "nfs_tools_volume" {
  name  = "esg_wp4_galaxy_nfs_share_tools"
  size  = 40
}

resource "openstack_compute_volume_attach_v2" "_nfs_tools_va" {
  instance_id = openstack_compute_instance_v2.nfs_instance.id
  volume_id   = openstack_blockstorage_volume_v3.nfs_tools_volume.id
}

resource "openstack_blockstorage_volume_v3" "nfs_galaxy_main_volume" {
  name  = "esg_wp4_galaxy_nfs_share_galaxy_main"
  size  = 40
}

resource "openstack_compute_volume_attach_v2" "_nfs_galaxy_main_va" {
  instance_id = openstack_compute_instance_v2.nfs_instance.id
  volume_id   = openstack_blockstorage_volume_v3.nfs_galaxy_main_volume.id
}