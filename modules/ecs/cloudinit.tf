data "aws_region" "current" {}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.userdata.rendered
  }

  part {
    content_type = "text/cloud-config"
    content      = var.ecs_user_init
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.sh")

  vars = {
    ecs_cluster    = aws_ecs_cluster.ecs_cluster.name
    region         = data.aws_region.current.name
    proxy_endpoint = var.proxy_endpoint
  }
}
