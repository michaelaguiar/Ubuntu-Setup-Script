#!/bin/bash

# Constants

VERSION="1.0.0"

# Install Lamp Stack

function install_lamp()
{
    echo '    -> Installing Lamp Stack';
    sudo apt-get install lamp-server^ &> /dev/null
    echo '    -> Lamp Stack Installed!';
}

# Enable Mod Rewrite

function enable_mod_rewrite()
{
    echo '    -> Enabling Mod Rewrite';
    sudo a2enmod rewrite &> /dev/null
    echo '    -> Mod Rewrite Enabled!';
}

# Secure MySQL Installation

function secure_mysql()
{
    echo '    -> Securing MySQL Installation';
    mysql_secure_installation &> /dev/null
    echo '    -> MySQL Installation Secured!';
}

# Install PHPMyAdmin

function install_phpmyadmin()
{
    echo '    -> Installing PHPMyAdmin';
    sudo apt-get install phpmyadmin
    sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf
    sudo apachectl restart &> /dev/null
    echo '    -> PHPMyAdmin Installed!';
}

# Install FTP Package

function install_ftp()
{
    echo '    -> Installing FTP';
    sudo apt-get install proftp &> /dev/null
    echo '    -> FTP Installed!';
}

# Update Server

function update_server()
{
    echo '    -> Updating Server';
    sudo aptitude update &> /dev/null && sudo aptitude safe-upgrade &> /dev/null
    echo '    -> Update Complete!';
}

# Change ownership of site directory

function change_site_ownership()
{
    echo '    -> Changing ownership of site directory';
    sudo chown www-data:www-data /var/www
    echo '    -> Ownership Changed!';
}

# Configure Firewall

function configure_firewall()
{
    echo '    -> Configuring Firewall';
    echo '        -> Setting defaults to deny';
    sudo ufw default deny
    echo '        -> Enabling ufw';
    sudo ufw enable
    echo '        -> Allow SSH Traffic';
    sudo ufw allow 22
    echo '        -> Allow Regular Traffic';
    sudo ufw allow 80
    echo '        -> Allow HTTPS Traffic';
    sudo ufw allow 443
    echo '    -> Firewall Configured!';
}

# Set Permissions
function set_permissions()
{
    echo '    -> Setting Permissions';
    sudo usermod -a -G www-data mike
    sudo chgrp -R www-data /var/www
    sudo chmod -R g+w /var/www
    sudo find /var/www -type d -exec chmod 2775 {} \;
    sudo find /var/www -type f -exec chmod ug+rw {} \;
    echo '    -> Permissions Set!';
}

function usage() {
  cat <<-EOF

  Usage: deploy [options] <env> [command]

  Options:

    -C, --chdir <path>   change the working directory to <path>
    -c, --config <path>  set config path. defaults to ./deploy.conf
    -T, --no-tests       ignore test hook
    -V, --version        output program version
    -h, --help           output help information

  Commands:

    setup                run remote setup commands
    update               update deploy to the latest release
    revert [n]           revert to [n]th last deployment or 1
    config [key]         output config file or [key]
    curr[ent]            output current release commit
    prev[ious]           output previous release commit
    exec|run <cmd>       execute the given <cmd>
    console              open an ssh session to the host
    list                 list previous deploy commits
    [ref]                deploy to [ref], the 'ref' setting, or latest tag

EOF
}

#
# Output version.
#

function version
{
    echo $VERSION
}

#
# Log <msg>.
#

function log
{
    echo "  > $@"
}


#
# Basic Web Server
#

#install_lamp
#enable_mod_rewrite
#secure_mysql
#install_phpmyadmin
#update_server

#
# Configure Web Server
#

#change_site_ownership

#
# Configure Firewall
#

configure_firewall

#
# Set Permissions
#

set_permissions
