data "aws_region" "current" {}

data "template_cloudinit_config" "config" {
  base64_encode = true
  gzip          = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata.rendered}"
  }

  part {
    content_type = "text/cloud-config"
    content      = var.proxy_user_init
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
    log_group = "GrayMetaPlatform-${var.platform_instance_id}-Proxy"
    region    = data.aws_region.current.name
    dns_name  = var.dns_name
    safelist  = join("\n", formatlist("        %s", var.safelist))
  }
}