tomcat_appliance
    type = puppet_appliance
    config
        vm_resources
            cloudify_agent
            tomcat
    endpoints
        tomcat
            exposes
                http_endpoint
                https_endpoint
   workflows
       start_appliance
       deploy_war
       undeploy_war
       restart_war

tomcat
    type = vm_resource
    config
        puppet_template = tomcat.pp
        chef_recipe = tomcat
    exposes_endpoints
        http_endpoint
        https_endpoint
    state_monitors
        tomcat_http_monitor

tomcat_resource
    type = resource
    hosted_by = tomcat

war_file
   type = tomcat_resource
   config
       path
   state_monitors
       java_servlet_http_monitor

http_endpoint
   type = tcp_endpoint
   config
        port = 80
        protocol = http

https_endpoint
    type = tcp_endpoint
    config
        port = 443
        protocol = https