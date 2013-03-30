cloudify_agent
    extends = vm_resource
    config
        monitor
           frequency = 5s
           round_trip = 10s
           lease = 1m
        puppet_template = "cloudify.pp"

    state_monitors
       cloudify_agent_round_trip_monitor