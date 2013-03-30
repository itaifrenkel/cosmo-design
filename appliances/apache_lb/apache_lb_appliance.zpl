apache_lb_appliance
    extends = puppet_appliance
    config
        virtual_machine = apache_lb_vm
        vm_resources
            cloudify_agent
            apache_lb

    wiring
        apache_lb
            exposes
                http_endpoint
                https_endpoint

   workflows
       start_appliance
       sync_web_servers

apache_lb
    extends = vm_resource

    config
        puppet_template = "apache_lb.pp"
        chef_recipe = "apache"

    endpoints
        apache_lb_http_endpoint
        apache_lb_https_endpoint

    state_monitors
        http_monitor

apache_lb_http_endpoint
   extends = endpoint
   config
       port = 80
       protocol = http

apache_lb_https_endpoint
    extends = endpoint
    config
        port = 443
        protocol = https
