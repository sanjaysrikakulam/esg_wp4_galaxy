output "rustus_instance_public_ip" {
  value = openstack_compute_instance_v2.rustus_instance.access_ip_v4
}

output "mq_instance_public_ip" {
  value = openstack_compute_instance_v2.mq_instance.access_ip_v4
}

output "galaxy_instance_public_ip" {
  value = openstack_compute_instance_v2.galaxy_instance.access_ip_v4
}

output "compute_instance_public_ip" {
    value = [openstack_compute_instance_v2.compute_instance.*.access_ip_v4]
}

output "pulsar_instance_public_ip" {
  value = [openstack_compute_instance_v2.pulsar_instance01.access_ip_v4]
}

output "nfs_instance_public_ip" {
  value = openstack_compute_instance_v2.nfs_instance.access_ip_v4
}

output "nfs_galaxy_data_volume_device" {
  value = openstack_compute_volume_attach_v2._nfs_galaxy_data_va.device
}
output "nfs_tools_volume_device" {
  value = openstack_compute_volume_attach_v2._nfs_tools_va.device
}

output "nfs_galaxy_main_volume_device" {
  value = openstack_compute_volume_attach_v2._nfs_galaxy_main_va.device
}