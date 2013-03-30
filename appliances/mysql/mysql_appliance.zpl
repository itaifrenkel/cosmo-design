mysql_appliance
    extends = puppet_appliance
    config
        virtual_machine = mysql_vm
        vm_resources
            cloudify_agent
            mysql
    endpoints
       mysql_endpoint = mysql.mysql_endpoint
    workflows
        start_appliance
        start_as_master
            tool = remote_script
            file = start_as_master.sh
        start_as_slave
            tool = remote_script
            file = start_as_slave.sh

mysql_vm
    extends = puppet_vm
    config
        size = m1.large

mysql
    extends = vm_resource
    config
        puppet_template = "mysql.pp"
    state_monitors
        mysql_server_monitor

