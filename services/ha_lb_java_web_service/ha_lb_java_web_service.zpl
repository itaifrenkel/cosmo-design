ha_lb_java_web_service

    config
        availability_zones
        number_of_web_appliances_per_zone = 2
        number_of_load_balancer_appliances_per_zone = 1

    services
        lb_java_web_service

    endpoints
        http_endpoint = lb_java_web_service.http_endpoint
        https_endpoint = lb_java_web_service.https_endpoint

   workflows
       install_service
       deploy_war_files
