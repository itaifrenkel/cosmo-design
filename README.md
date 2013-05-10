Cosmo semantics
===============

[Diagram of a sample petclinic application](http://prezi.com/umc6y1rhco_i/cosmo-semantics/?kw=view-umc6y1rhco_i&rc=ref-37008791)


# Examples #

## Node Example ##
### Software Infra Example ###

	{
    	// resource type
		"type" : "sw_infra_resource",

		//software name
		"name" : "tomcat",

		// various ways to install and configure this software
    	"configurers" : {
			"puppet" : {
				"config" : "tomcat.pp"
			},
			"chef" : {
				"config" : "tomcat.rb"
			}
		}

		// network endpoints exposed by this software
    	"endpoints" : {
			{   "type" : "http_endpoint",
				"port" : "8080"    		
			}
		}
    
		// ways to monitor this software
		"monitors" : {
			"http_monitor"
		}
    

### Node Example ###
	{
		// resource type
		"type" : "node",
	
		// node name
		name : "tomcat_node",
	
		// resources aggregated by this node
	    "resources" : { 
			"cloudify_agent", 
			"tomcat" 
		},
	
		// aggregated network endpoints of that are accesible outside the node
	    "endpoints" : {
	        "http_endpoint" : "tomcat.http_endpoint",
	        "https_endpoint" : "tomcat.https_endpoint"
	    },
	
		// tasks supported by this node
		"tasks" : {
	    	"start_appliance",
	        "deploy_war",
	        "undeploy_war",
	        "restart_war"
		}
	}


## Tier Example##

	{
		// resource type
    	"type" : "tier",

		//tier name
		"name" : "java_web_tier",

		// manual and automatic scaling specification
    	"scale" : {
        	"web_instances" : "2",
        	"load_balancer_instances" : "1"
		}

		// application modules to deploy on installation
		// empty by default, unless overriden
    	"war_modules" : { }

		// nodes comprising this tier
    	"nodes": {
        	{ "name" : "web_node",
			  "type" : "tomcat_node"
			},
			{ "name" : "load_balancer_node",
			  "type" : "apache_lb_node"
			}
		}

		// internal wiring between network endpoints inside the tier
	    "network_wiring" : {
	        {
				"type" : "network_wiring",
				"from" : "load_balancer_node",
				"to"   : { 
	        		"web_node.http_endpoint",
	        		"web_node.https_endpoint"
				}
			},
	
		// aggregated network endpoints that are accesible outside the tier
    	"endpoints" : {
				"http_endpoint" : "load_balancer_appliance.http_endpoint",
        	  	"https_endpoint" : "load_balancer_appliance.https_endpoint"
		},

		// tasks supported by this tier
   		"tasks" : {
       		"install_service",
       		"deploy_war_module",
       		"scale_out",
       		"scale_in",
       		"on_appliance_failed"
		}
	}


## Application Example ##

### Module Example ###
	{
		"name" : "petclinic_module",
		"type" : "war_module",
		"file" : "petclinic.war"
	}

### Lean App example ###
	{
		"name" : "petclinic_application"
		"tiers" : {
			{
				"type" : "java_web_tier",
				"depends_on" : { "db_tier" }
			},
			{
				"type" : "mysql_tier",
				"persistency" : {
   					"snapshot_tag" : "petclinic_mysql_snapshot"
				}
			}
	}


   
### Full Application Example ###

 	{
		{
			"name" : "petclinic_application"
	    	"type" : "application"
	    	"tiers" : { "application_tier", "database_tier" }
	
		},
		{
			// tier name
	   		"name" : "application_tier",
			
			//tier type
			"type" : "java_web_tier",

			//tier scale overrides
			"scale" : {
				"web_instances" : "4"
			},

			// override application modules to start automatically
			"war_modules" : {
				"petclinic_module"
			},

			//network wiring between tiers
			"network_wiring" : {
				"name" : "petclinic_depends_on_mysql"
				"type" : "network_wiring"
				"from" : "petclinic_module"
				"to" : "database_service.mysql_endpoint"
				"policies" : {
				 	"open_firewall",
				    "restart_on_endpoints_change",
				    "wait_for_single_endpoint_before_start"
				}
		},
		{
			// tier name
			"name" : "database_tier",

			// tier type
			"type" : "mysql_tier",

			//override attached drive snapshot
			"persistency" : {
					"snapshot_tag" : "petclinic_mysql_snapshot"
			}
		}
	} 


#Resource#

A resource is the smallest building block that can be monitored for state (availability),
metered(usage) and associated with a tenant (user quota/ permissions).

Examples for Resources:
- java servlet
- tomcat (process)
- virtual machine
- availability zone
- Amazon Elastic IP
- Amazon EBS volume
- Amazon snapshot

Two resources could have a hosted_by relationship, for better correlation of availability monitoring.
java_servlet is hosted by a tomcat process which is hosted in a virtual machine which is hosted in an availability
zone


#Node#
A node is a standalone usable "deployed software" that can be consumed and managed via the network.
A node is usually formed by an aggregation of resources that include one virtual machine and one agent running
on that vm.
When the lifecycle of the node ends (terminates), some resources may still be allocated (such as elastic ip,
EBS snapshot, etc...)

Examples of a node:
- A mysql node is aggregation of virtual machine, mysql process, attached volume, agent.
- A load balancer node is aggregation of virtual machine, apache process, elastic ip, agent.
- Amazon RDS DB Instance

#Tier#
A tier could be defined as an aggregation of nodes, their wiring, ability to recover from failures,
and scale policy.

Example for a Tier aggregating appliances:
- A tomcat service that aggregates a load balancer node with tomcat nodes and defines failover recovery
and scale workflows.
- Two mysql nodes and workflows that implement master/slave mode.

A tier could also aggregate other tiers:
- An aggregation of two tomcat tiers, one in each availability zone that compose one HA tomcat tier.

A tier could be defined by 3rd party APIs:
- Amazon Elastic Load Balancer

#Application#
An aggregation of services, one of which is exposed to the end-user.

For example, the petclinic application is an aggregation of a H/A load balanced tomcat service running petclinic.war
and mysql service persisting the data.

#Network Endpoints and Wiring#
Each resource/node/tier can expose a network endpoint (which roughly represents a listening tcp server).
For example, the tomcat resource exposes an http endpoint.

This endpoint by default could only be accessed from other resources in the same appliance that tomcat is part of.
In order for other appliances (such as the load balancer) to consume the tomcat endpoint:
- The tomcat appliance must expose the tomcat endpoint explicitly.
- The service comprising of the tomcat and load balancer appliance needs to wire them together

