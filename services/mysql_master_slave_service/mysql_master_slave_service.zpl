mysql_master_slave_service
    alias = mysql
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
                    mysql_endpoint

    workflows
        install_service
        switch_master