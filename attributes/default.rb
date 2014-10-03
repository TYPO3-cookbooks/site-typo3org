force_default['php']['packages'] = %w{
  php5
  php5-cgi
  php5-cli
  php5-common
  php5-curl
  php5-dev
  php5-gd
  php5-mcrypt
  php5-mysql
  php-pear
  php5-xmlrpc
  php5-xsl
}

force_default['apache']['default_modules'] = %w{
  alias auth_basic authn_file authz_default authz_groupfile authz_host authz_user
  autoindex cgid deflate dir env expires fcgid headers mime negotiation reqtimeout
  rewrite setenvif status suexec
}

# @TODO: mod_rpaf

# General settings
force_default['apache']['listen_addresses']  = %w(*)
force_default['apache']['listen_ports']      = %w(80)
force_default['apache']['contact']           = 'admin@typo3.org'
force_default['apache']['timeout']           = 300
force_default['apache']['keepalive']         = 'On'
force_default['apache']['keepaliverequests'] = 100
force_default['apache']['keepalivetimeout']  = 15
force_default['apache']['sysconfig_additional_params'] = {}

# Prefork Attributes
force_default['apache']['prefork']['startservers']        = 5
force_default['apache']['prefork']['minspareservers']     = 5
force_default['apache']['prefork']['maxspareservers']     = 10
force_default['apache']['prefork']['serverlimit']         = 150
force_default['apache']['prefork']['maxrequestworkers']   = 256
force_default['apache']['prefork']['maxconnectionsperchild'] = 0

# Worker Attributes
force_default['apache']['worker']['startservers']        = 2
force_default['apache']['worker']['minsparethreads']     = 25
force_default['apache']['worker']['maxsparethreads']     = 75
force_default['apache']['worker']['threadlimit']         = 64
force_default['apache']['worker']['threadsperchild']     = 150
force_default['apache']['worker']['maxrequestworkers']   = 150
force_default['apache']['worker']['maxconnectionsperchild'] = 0

default['site-typo3org']['apache']['vhosts'] = [
    {
        name: 'production',
        domain: 'typo3.org',
        domain_aliases: %w{
            www.typo3.org
            preview.typo3.org
            www.preview.typo3.org
            typo3.com
            www.typo3.com
            t3o.typo3.org
            news.typo3.org
            typo3org.srv107.typo3.org
            get.typo3.org
            certification.typo3.org
        },
        user: 'typo3org',
        root_dir: node['apache']['docroot_dir'] + '/vhosts/typo3.org/home'

    }
]