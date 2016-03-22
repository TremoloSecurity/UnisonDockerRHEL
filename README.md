# Tremolo Security's Unison

![Tremolo Security, Inc. Logo](https://www.tremolosecurity.com/site/wp-content/uploads/Tremolo-Logo-31.png)

Tremolo Security's Unison combines the identity management functions most needed by applications including:

* User Provisioning
* SSO
* LDAP Virtual Directory
* Reporting
* Workflow

## Available Tags

* latest (1.0.6)
* 1.0.6

## Deployment

Prior to deployment, a license must be obtained.  A 60 day trial license can be obtained by registering at https://www.tremolosecurity.com/support/ .  Once a license is obtained, the Unison image can be deployed from the standard dockerhub image without change.  This build is automatic and tied to the centos repository so whenever a new centos 7 image is pushed this image is updated.

## Clustering

If your docker servers are static and can port forward from the host to Unison you can use the standard Unison clustering mechanism for pushing configurations.  Since most docker deployments are more dynamic the more effective approach is to have shared volumes using either an NFS driver, GlusterFS, etc.  Configure Unison to use a shared file system (under Admin System).  This will reload the configuration when it is changed based on a marker on the shared file system.  See the dockerfile for a list of shared volumes that need to be created for this image.

## Logging

The standard for Docker images is to send all output to standard out.  The default log4j.xml file is updated to push all output to standard out instead of the different log files.
