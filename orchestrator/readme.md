resource layer
--------------
    _start_monitoring_resource_state
    _stop_monitoring_resource_state
    wait_for_state

    get_availability_zones
    create_volume
    start_virtual_machine

    run_script_on_vm

appliance layer
---------------
    start appliance
    stop appliance
    wait_for_state
    run_workflow

    list aggregated resources
    add_aggregated_resource

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
    open_firewall
    wait_for_single_endpoint
    on_wiring_changed

    list_aggregated_availability_zones