Cosmo semantics
===============

[Diagram of a sample petclinic application](http://prezi.com/umc6y1rhco_i/cosmo-semantics/?kw=view-umc6y1rhco_i&rc=ref-37008791)

Resource
--------
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


Appliance
---------
An appliance is a standalone usable "deployed software" that can be consumed and managed via the network.
An appliance is usually formed by an aggregation of resources that include one virtual machine and one agent running
on that vm.
When the lifecycle of the appliance ends (terminates), some resources may still be allocated (such as elastic ip,
EBS snapshot, etc...)

Examples of an appliance:
- A mysql appliance is aggregation of virtual machine, mysql process, attached volume, agent.
- A load balancer appliance is aggregation of virtual machine, apache process, elastic ip, agent.
- Amazon RDS DB Instance

Service
-------
A service could be defined as an aggregation of appliances, their wiring, ability to recover from failures,
and scale policy.

Example for a Service aggregating appliances:
- A tomcat service that aggregates a load balancer appliance with tomcat appliances and defines failover recovery
and scale workflows.
- Two mysql appliances and workflows that implement master/slave mode.

A service could also aggregate other services:
- An aggregation of two tomcat services, one in each availability zone that compose one HA tomcat service.

A service could be defined by 3rd party APIs:
- Amazon Elastic Load Balancer

Application
------------
An aggregation of services, one of which is exposed to the end-user.

For example, the petclinic application is an aggregation of a H/A load balanced tomcat service running petclinic.war
and mysql service persisting the data.

Network Endpoints and Wiring
----------------------------
Each resource/appliance/service can expose a network endpoint (which roughly represents a listening tcp server).
For example, the tomcat resource exposes an http endpoint.

This endpoint by default could only be accessed from other resources in the same appliance that tomcat is part of.
In order for other appliances (such as the load balancer) to consume the tomcat endpoint:
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
