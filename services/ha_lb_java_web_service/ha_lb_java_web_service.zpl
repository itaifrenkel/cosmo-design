ha_lb_java_web_service

    scale
        availability_zones = 2
        web_instances_per_zone = 2
        load_balancer_instances_per_zone = 1

    services
        lb_java_web_service

    endpoints
        http_endpoint = lb_java_web_service.http_endpoint
        https_endpoint = lb_java_web_service.https_endpoint

   workflows
       install_service
       deploy_war_module
