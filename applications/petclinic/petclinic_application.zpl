petclinic_service
    type = java_service
    scale
        web_instances = 4

database_service
   type = mysql_service
   persistency
       snapshot = petclinic_mysql_snapshot