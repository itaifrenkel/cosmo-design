vm_appliance
   extends = appliance
   config
       virtual_machine
       security_groups
       elastic_ip
       attached_volumes
   workflows
       start_appliance
       monitor
       unmonitor
       run_script_on_vm

vm_resource
   config
       hosted_by = virtual_machine