# docker-mailserver-postfixadmin
This is a Docker image for a PostfixAdmin WebUI. The project is part of the 
[docker-mailserver](https://github.com/technicalguru/docker-mailserver) project but can run separately 
without the other components. However, a database server is always required to store structural data. 

Related images:
* [docker-mailserver](https://github.com/technicalguru/docker-mailserver) - The main project, containing composition instructions
* [docker-mailserver-postfix](https://github.com/technicalguru/docker-mailserver-postfix) - Postfix/Dovecot image (mailserver component)
* [docker-mailserver-amavis](https://github.com/technicalguru/docker-mailserver-amavis) - Amavis, ClamAV and SpamAssassin (provides spam and virus detection)
* [docker-mailserver-roundcube](https://github.com/technicalguru/docker-mailserver-roundcube) - Roundcube Webmailer

# Tags
The following versions are available from DockerHub. The image tag matches the PostfixAdmin version.

* [3.2.4-01, 3.2.4, 3.2, 3, latest](https://hub.docker.com/repository/docker/technicalguru/mailserver-postfixadmin) - [Dockerfile](https://github.com/technicalguru/docker-mailserver-postfixadmin/blob/3.2.4-01/Dockerfile)

# Features
* Database and PostfixAdmin setup from environment variables

# License
_docker-mailserver-postfixadmin_  is licensed under [GNU LGPL 3.0](LICENSE.md). As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# Prerequisites
The following components must be available at runtime:
* [MySQL >8.0](https://hub.docker.com/\_/mysql) or [MariaDB >10.4](https://hub.docker.com/\_/mariadb) - used as database backend for domains and mailboxes. 

# Usage

## Environment Variables
_docker-mailserver-postfixadmin_  requires various environment variables to be set. The container startup will fail when the setup is incomplete.

| **Variable** | **Description** | **Default Value** |
|------------|---------------|-----------------|
| `PFA_SETUP_PASS` | The PostfixAdmin setup password. |  |
| `PFA_DB_HOST` | The hostname or IP address of the database server |  |
| `PFA_DB_USER` | The name of the database user. **Attention!** You shall not use an administrator account. |  |
| `PFA_DB_PASS` | The password of the database user |  |
| `PFA_DB_NAME` | The name of the database | |
| `PFA_POSTFIX_SERVER` | The hostname of your SMTP server. Postfix requires this to send out initial e-mail for mailboxes. |  |
| `PFA_ABUSE_EMAIL` | E-mail address to be informed about abuses. |  |
| `PFA_HOSTMASTER_EMAIL` | E-mail address to be informed about issues with the host image. |  |
| `PFA_POSTMASTER_EMAIL` | E-mail address to be informed about mailbox and domain issues. |  |
| `PFA_WEBMASTER_EMAIL` | E-mail address to be informed about issues with the WebUI. |  |

## Ports
_docker-mailserver-postfixadmin_  exposes port 80 (the WebUI). No TLS support is built in. So you shall put your container behind an Ingress or Reverse Proxy that enforces HTTPS.

## Running the Container
The [main mailserver project](https://github.com/technicalguru/docker-mailserver) has examples of container configurations:
* [with docker-compose](https://github.com/technicalguru/docker-mailserver/tree/master/examples/docker-compose)
* [with Kubernetes YAML files](https://github.com/technicalguru/docker-mailserver/tree/master/examples/kubernetes)
* [with HELM charts](https://github.com/technicalguru/docker-mailserver/tree/master/helm-charts)

## Bootstrap and Setup
Once you have started your PostfixAdmin container successfully, it is now time to perform the first-time setup for your mailserver. Open the web interface and navigate to `/public/setup.php`.

1. Enter the setup password as you provided it with environment variable `PFA_SETUP_PASS`.
1. Create your PostfixAdmin administrator account. This is the main account to PostfixAdmin. It will enable you to create domains, mailboxes, aliases, etc.
1. Login to PostfixAdmin by navigating to `/public/login.php`.
1. Create your primary domain.
1. Create your first mailbox in this domain.

# Additional PostfixAdmin customization
You can further customize `config.inc.local.php`. Please follow these instructions:

1. Get a copy of the file from the `/var/www/html` folder. 
1. Customize your configuration file.
1. Provide your customized file back into the `/var/www/html` by using a volume mapping.

# Issues
This Docker image is mature and supports my own mailserver in production. There are no known issues at the moment.


# Contribution
Report a bug, request an enhancement or pull request at the [GitHub Issue Tracker](https://github.com/technicalguru/docker-mailserver-postfixadmin/issues).

