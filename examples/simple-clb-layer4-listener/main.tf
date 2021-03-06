module "clb-instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type = "INTERNAL"
  clb_name     = "tf-clb-module-internal"
  vpc_id       = "vpc-h70b6b49"
  subnet_id    = "subnet-1uwh63so"
  project_id   = 0

  clb_tags = {
    test = "tf-clb-module"
  }
}

module "clb-layer4-listener" {
  source = "terraform-tencentcloud-modules/clb-layer4-listener/tencentcloud"

  clb_id        = module.clb-instance.clb_id
  listener_name = "tf-clb-listener-module"
  port          = 80
  protocol      = "TCP"
  health_check = {
    health_check_switch        = true
    health_check_time_out      = 2
    health_check_interval_time = 5
    health_check_health_num    = 3
    health_check_unhealth_num  = 3
  }
  backend_instances = [
    {
      instance_id = "ins-b8bowoum"
      port        = 8899
      weight      = 50
    },
    {
      instance_id = "ins-mabscyug"
      port        = 8900
      weight      = 50
    }
  ]
}