% Unison (1) Container Image Pages
% Tremolo Security, Inc.
% February 21, 2017

# NAME
unison \- Unison RHEL Container

# DESCRIPTION

Tremolo Security's Unison combines the identity management functions most needed by applications including:

* User Provisioning
* SSO
* LDAP Virtual Directory
* Reporting
* Workflow

# USAGE

## Deployment

Prior to deployment, a license must be obtained.  A 60 day trial license can be obtained by registering at https://www.tremolosecurity.com/support/ .  Once a license is obtained, the Unison image can be deployed from the Red Hat container catalog without change.

## Clustering

To use the Unison container in a high availability mode, use a `Persistent Volume` mounted to `/usr/local/tremolo/tremolo-service/external`.  Then, configure Unison pods to use to use a shared file system (under Admin System).  This will reload the configuration when it is changed based on a marker on the shared file system.  It is recommended that you define one pod as an administrator pod with write access to the `Persistent Volume` and the others with read-only access.

## Logging

The standard for Docker images is to send all output to standard out.  The default log4j2.xml file is updated to push all output to standard out instead of the different log files.


# SECURITY IMPLICATIONS

Unison runs unprivileged and without any ports below 1024.

# AUTHORS
Tremolo Security, Inc.
