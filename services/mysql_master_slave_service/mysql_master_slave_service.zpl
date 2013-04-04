mysql_master_slave_service
    config
        availability_zones
        mysql_snapshot
        attached_volume_zone1
        attached_volume_zone2

    appliances
        mysql_appliance

    endpoints
        mysql_appliance
            exposes
                mysql_endpoint
            consumes
                mysql_appliance
                    endpoints
                        mysql_endpoint

    workflows
        install_service
        switch_master