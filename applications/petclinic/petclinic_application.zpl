 petclinic
     type = java
     config
         instances = 4
#        war_files
#            petclinic_war_file
#    endpoints
#        petclinic_war_file
#            consumes
#                database
#                    endpoints
#                        mysql_endpoint
#                    policies
#                        restart_on_endpoints_change
#                        wait_for_single_endpoint_before_start

 database
     type = mysql
     config
         snapshot = petclinic_mysql_snapshot

#petclinic_war_file
#    type = war_file
#    config
#        file = petclinic.war