mysql_master_slave_service
    type = service
    persistency
        snapshot
        attached_volume_zone1
        attached_volume_zone2

    appliances
        mysql_appliance

    endpoints
        mysql_endpoint = mysql_appliance.mysql_endpoint

    network_wiring
        mysql_slave_network_wiring

    workflows
        install_service
        switch_master

mysql_slave_network_wiring
    type = network_wiring
    from
        mysql_appliance
    to
        mysql_appliance.mysql_endpoint