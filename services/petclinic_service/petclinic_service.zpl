mysql_lb_java_web_service
    config
        number_of_web_appliances_per_availability_zone = 2
        mysql_snapshot = petclinic_mysql_snapshot
        war_files
            petclinic_war_file

    services
        mysql_master_slave_service
        ha_lb_java_web_service

    workflows
        install_service

petclinic_war_file
    extends = war_file
    config
        file = petclinic.war
    wiring
        consumes_endpoints
            mysql_master_slave_service
                mysql_endpoint
