apache_lb_appliance
    type = puppet_appliance
    config
        virtual_machine = apache_lb_vm
        vm_resources
            cloudify_agent
            apache_lb

    endpoints
        http_endpoint = apache_lb.http_endpoint
        https_endpoint = apache_lb.https_endpoint

   workflows
       start_appliance
       sync_web_servers

apache_lb
    type = vm_resource

    config
        puppet_template = "apache_lb.pp"
        chef_recipe = "apache"

    endpoints
        apache_lb_http_endpoint
        apache_lb_https_endpoint

    state_monitors
        http_monitor

apache_lb_http_endpoint
   type = endpoint
   config
       port = 80
       protocol = http

apache_lb_https_endpoint
    type = endpoint
    config
        port = 443
        protocol = https
