resource layer
--------------
    monitor_resource_state
    unmonitor_resource_state
    get_availability_zones
    create_volume
    start_virtual_machine
    run_script_on_vm
    configure_security_group_rule (based on endpoint wiring)

appliance layer
---------------
    start appliance
    stop appliance
    run appliance workflow
    list aggregated resources

service layer
-------------
    get wiring information (ip address/port/etc...)
    list_aggregated_appliances
    list_aggregated_services
    run service workflow
    on_appliance_failed