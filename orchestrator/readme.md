resource layer
--------------
    _start_monitoring_resource_state
    _stop_monitoring_resource_state
    await for state

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
    on_appliance_failed

    list_aggregated_services
    on_service_failed

    start service
    stop service
    run service workflow

    update_scale_plan
    get_appliances_planned_for_start
    get_appliances_planned_for_stop


    list_network_wiring (from/to/policy/ip address/port/etc...)
    configure_security_group_rule (based on endpoint wiring)
    on_wiring_changed