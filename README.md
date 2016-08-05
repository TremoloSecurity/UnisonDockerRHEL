# Tremolo Security's Unison

![Tremolo Security, Inc. Logo](https://www.tremolosecurity.com/site/wp-content/uploads/Tremolo-Logo-31.png)

Tremolo Security's Unison combines the identity management functions most needed by applications including:

* User Provisioning
* SSO
* LDAP Virtual Directory
* Reporting
* Workflow

## Available Tags

* latest (registry-tremolosecurity.rhcloud.com/rhel7/unison)
* registry-tremolosecurity.rhcloud.com/rhel7/unison:1.0.7
* registry-tremolosecurity.rhcloud.com/rhel7/unison:1.0.6


## Deployment

Prior to deployment, a license must be obtained.  A 60 day trial license can be obtained by registering at https://www.tremolosecurity.com/support/ .  Once a license is obtained, the Unison image can be deployed from the standard dockerhub image without change.  This build is automatic and tied to the centos repository so whenever a new centos 7 image is pushed this image is updated.

## Clustering

If your docker servers are static and can port forward from the host to Unison you can use the standard Unison clustering mechanism for pushing configurations.  Since most docker deployments are more dynamic the more effective approach is to have shared volumes using either an NFS driver, GlusterFS, etc.  Configure Unison to use a shared file system (under Admin System).  This will reload the configuration when it is changed based on a marker on the shared file system.  See the dockerfile for a list of shared volumes that need to be created for this image.

## Logging

The standard for Docker images is to send all output to standard out.  The default log4j.xml file is updated to push all output to standard out instead of the different log files.

## Running Unison in a Container

### Volumes
A single volume needs to be mapped to /usr/local/tremolo/tremolo-service/external.  On startup, Unison will copy the applications, configurations and external libraries to this volume.  Its also where the markers used in a shared filesystem clustering configuration are stored.

### Ports
The following ports are available:
* 9090 - Administrative Portal Port
* 8080 - Web Unencrypted
* 8443 - Web Encrypted
* 10983 - LDAP Unencrypted
* 10636 - LDAP Secure
* 9093 - Admin web services

NOTE that these ports are defaults and can be configured inside of the Unison admin interface

### Example Docker Command
```
docker run -d -p 9090:9090 -p 389:10983 -p 636:10636 -p 80:8080 -p 443:8443 --name unison -v /var/lib/docker-volumes/unison:/usr/local/tremolo/tremolo-service/external:Z  registry-tremolosecurity.rhcloud.com/rhel7/unison:1.0.7
```
Once the container is running, it can be connected to with https://docker.host:9090 to configure the license and initial security information.
