puppet_appliance
    extends = vm_appliance
    config
        virtual_machine = puppet_vm
        vm_resources
            puppet_agent
    workflows
        start_appliance

puppet_agent
    extends = resource
    state_monitors
       puppet_agent_monitor

puppet_vm
    extends = virtual_machine
    config
        image = ubuntu_with_puppet