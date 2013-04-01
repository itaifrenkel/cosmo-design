lb_java_web_service
    extends = service
    config
        number_of_web_appliances = 2
        number_of_load_balancer_appliances = 1
        war_files

    appliances
        web_appliance = tomcat_appliance
        load_balancer_appliance = apache_lb_appliance

    endpoints
        load_balancer_appliance
            exposes
                http_endpoint
                https_endpoint
            consumes
                web_appliance
                    http_endpoint
                    https_endpoint

   workflows
       install_service
       deploy_war_files
       scale_out
       scale_in
       on_appliance_failed