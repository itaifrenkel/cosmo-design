Cosmo semantics
===============

[Diagram of a sample petclinic application](http://prezi.com/umc6y1rhco_i/present/?auth_key=f4maydp&follow=5xdtha9eofgw)

resource
--------
A resource is the smallest defining element of a service. 
A resource state can be monitored (availability), metered(usage) and associated with a tenant (user quota/ permissions).

Two resources could have a hosted_by relationship, for better correlation of availability monitoring.

Examples for Resources:
- java servlet (is hosted by)
- tomcat (is hosted by) 
- virtual machine (is hosted by)
- availability zone.

Appliance
---------
An aggregation of resources that form a standalone unit of a service.

-A mysql appliance is aggregation of virtual machine, mysql process, attached volume.
-A load balancer appliance is aggregation of virtual machine, apache process, elastic ip.

Service
-------
A network endpoint with an API which can scale and recover from failures. 
A service could be defined as an aggregation of appliances, aggregation of services, or via 3rd party APIs.

Example for a Service:
- A tomcat service that aggregates a load balancer appliance with tomcat appliances and define the failover recover and scale workflows.
- An aggregation of two tomcat services, one in each availability zone.
- Two mysql appliances and workflows that implement master/slave mode.
- Amazon Elastic Load Balancer

Application
------------
An aggregation of services, one of which is exposed to the end-user.

Network Endpoints and Wiring
----------------------------
Each resource/appliance/service can define a network endpoint (which roughly represents a listening tcp server). 
When the tomcat resource exposes an http endpoint, it can be wired to other resources in the same appliance that tomcat is part of. 
In order for other appliances (such as the load balancer) to consume the endpoint:
- The tomcat appliance must expose the tomcat endpoint explicitly. 
- The service comprising of the tomcat and load balancer appliance needs to wire them together


Cosmo syntax
============
zpl - configuration file format
-------------------------------
    hierarchical
    easy to merge two files together (no arrays, every item has a name)
    easy to edit by a human without making an error
    can be parsed, streamed, generated
    easily converted into global properties map
    secure (no code)
    open-source community: zeromq, 120 contributors
    spec is GPL license, implementations are LGPL (FileMQ), may need to implement parser ourselves.

ruote - workflow dsl
--------------------
    separates workflow from providers (implementation as a service)
    secure (has a DSL variant that does not require ruby parser, only hook is the ${dollar} notation which does not parse ruby by default.
    supports global variables injection
    open-source community: ruote, 29 contributors, permissive license

drools - event rules dsl 
------------------------
    used for monitoring state using event rules (drools expert + drools fusion)
    secure (need to control package imports like drools governor does)
    supports global variables injection     
    open-source community: redhat/jboss/drools, 96 contributors, permissive license

camel - event pipeline dsl
--------------------------
    used for distributing events between state monitors and ruote workflows
    used for distributing events between state monitors and drools
    open-source community: apache, 49 contributors, permissive license
