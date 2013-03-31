java
    config
        number_of_web_appliances_per_availability_zone = 2
        war_files
            petclinic_war_file
mysql
    config
        mysql_snapshot = petclinic_mysql_snapshot

petclinic_war_file
    extends = war_file
    config
        file = petclinic.war
    wiring
        consumes_endpoints
            mysql