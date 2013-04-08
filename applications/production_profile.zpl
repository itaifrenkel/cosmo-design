java_service
    type = ha_lb_java_web_service
    scale
        web_instances = 3
mysql_service
    type = mysql_master_slave_service