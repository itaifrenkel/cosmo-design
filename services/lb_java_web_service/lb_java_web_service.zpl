lb_java_web_service
    type = service

    scale
        web_instances = 2
        load_balancer_instances = 1

    war_modules

    appliances
        web_appliance = tomcat_appliance
        load_balancer_appliance = apache_lb_appliance

    network_wiring
        load_balancer_to_web_wiring

    endpoints
        http_endpoint = load_balancer_appliance.http_endpoint
        https_endpoint = load_balancer_appliance.https_endpoint

   workflows
       install_service
       deploy_war_files
       scale_out
       scale_in
       on_appliance_failed

load_balancer_to_web_wiring
    type = network_wiring
    from
        load_balancer_appliance
    to
        web_appliance.http_endpoint
        web_appliance.https_endpoint
    policies
        open_firewall