resource layer
--------------
    monitor_resource_state
    unmonitor_resource_state
    get_availability_zones
    create_volume
    start_virtual_machine
    run_script_on_vm

appliance layer
---------------
    list aggregated resources
    start appliance
    stop appliance
    run appliance workflow


service layer
-------------
    list_aggregated_appliances
    list_aggregated_services
    start service
    stop service
    run service workflow

    get wiring information (ip address/port/etc...)
    configure_security_group_rule (based on endpoint wiring)
    on_appliance_failed
    on_wiring_changed