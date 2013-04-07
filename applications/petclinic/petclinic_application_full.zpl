petclinic_service
     type = java_service
     scale
         web_instances = 4

     war_modules
        petclinic_module

     network_wiring
         petclinic_depends_on_mysql

database_service
    type = mysql_service
    config
        snapshot = petclinic_mysql_snapshot

petclinic_module
    type = war_module
    config
        file = petclinic.war

petclinic_depends_on_mysql
    type = network_wiring
    from
        petclinic_module
    to
        database.mysql_endpoint
    policies
        restart_on_endpoints_change
        wait_for_single_endpoint_before_start