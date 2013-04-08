application_service
    type = java_service
    depends_on
        database_service

database_service
   type = mysql_service
   persistency
       snapshot_tag = petclinic_mysql_snapshot