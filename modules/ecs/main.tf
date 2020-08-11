# data "aws_subnet" "ecs_subnet_1" {
#   id = "${var.ecs_subnet_id_1}"
# }

# data "aws_subnet" "ecs_subnet_2" {
#   id = "${var.ecs_subnet_id_1}"
# }

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "GrayMetaPlatform-${var.platform_instance_id}"
}