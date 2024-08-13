variable "zone_usegalaxy_esg" {
  default = "Z01073613RSOPT6AT1IJF"
}

resource "aws_route53_record" "galaxy-instance" {
  allow_overwrite = true
  zone_id         = var.zone_usegalaxy_esg
  name            = "galaxyesginstance.esgwps.lol"
  type            = "A"
  ttl             = "7200"
  records         = [openstack_compute_instance_v2.galaxy_instance.access_ip_v4]
}

resource "aws_route53_record" "usegalaxy-esg" {
  allow_overwrite = true
  zone_id         = var.zone_usegalaxy_esg
  name            = "usegalaxy.esgwps.lol"
  type            = "CNAME"
  ttl             = "7200"
  records         = [openstack_compute_instance_v2.galaxy_instance.access_ip_v4]
}

resource "aws_route53_record" "galaxy-esg-mq" {
  allow_overwrite = true
  zone_id         = var.zone_usegalaxy_esg
  name            = "mqesginstance.esgwps.lol"
  type            = "A"
  ttl             = "7200"
  records         = [openstack_compute_instance_v2.mq_instance.access_ip_v4]
}

resource "aws_route53_record" "galaxy-esg-rustus" {
  allow_overwrite = true
  zone_id         = var.zone_usegalaxy_esg
  name            = "uploadesginstance.esgwps.lol"
  type            = "A"
  ttl             = "7200"
  records         = [openstack_compute_instance_v2.rustus_instance.access_ip_v4]
}
