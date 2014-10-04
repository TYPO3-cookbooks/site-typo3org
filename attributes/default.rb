normal['php']['packages'] = %w{
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

normal['apache']['default_modules'] = %w{
  alias auth_basic authn_file authz_core authz_groupfile authz_host authz_user
  autoindex cgid deflate dir env expires fcgid headers mime negotiation reqtimeout
  rewrite setenvif status suexec
}

# General settings
normal['apache']['listen_addresses']  = %w(127.0.0.1)
normal['apache']['listen_ports']      = %w(8080)
normal['apache']['contact']           = 'admin@typo3.org'
normal['apache']['timeout']           = 300
normal['apache']['keepalive']         = 'On'
normal['apache']['keepaliverequests'] = 100
normal['apache']['keepalivetimeout']  = 15
normal['apache']['sysconfig_additional_params'] = {}

# Prefork Attributes
normal['apache']['prefork']['startservers']        = 5
normal['apache']['prefork']['minspareservers']     = 5
normal['apache']['prefork']['maxspareservers']     = 10
normal['apache']['prefork']['serverlimit']         = 150
normal['apache']['prefork']['maxrequestworkers']   = 256
normal['apache']['prefork']['maxconnectionsperchild'] = 0

# Worker Attributes
normal['apache']['worker']['startservers']        = 2
normal['apache']['worker']['minsparethreads']     = 25
normal['apache']['worker']['maxsparethreads']     = 75
normal['apache']['worker']['threadlimit']         = 64
normal['apache']['worker']['threadsperchild']     = 150
normal['apache']['worker']['maxrequestworkers']   = 150
normal['apache']['worker']['maxconnectionsperchild'] = 0

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
        root_dir: node['apache']['docroot_dir'] + '/vhosts/typo3.org',
        doc_root: node['apache']['docroot_dir'] + '/vhosts/typo3.org/htdocs',
        log_root: node['apache']['docroot_dir'] + '/vhosts/typo3.org/logs',
        tmp_root: node['apache']['docroot_dir'] + '/vhosts/typo3.org/tmp',
        home_root: node['apache']['docroot_dir'] + '/vhosts/typo3.org/home',
        fcgi_root: node['apache']['docroot_dir'] + '/vhosts/typo3.org/fcgi',
    }
]

normal['varnish']['version'] = '3.0'
normal['varnish']['storage'] = 'malloc'
normal['varnish']['storage_size'] = '2G'
default['site-typo3org']['varnish']['vhosts'] = [
    {
        name: 'production',
        backend_host: '127.0.0.1',
        backend_port: 8080,
        listen_address: '',
        listen_port: 6081,
    }
]

default['site-typo3org']['nginx']['vhosts'] = [
    {
        name: 'production',
        backend_host: '127.0.0.1',
        backend_port: 6081,

        domains: %w{ .typo3.org .typo3.com .typo3.de },
        listen_port_http: 80,
        listen_port_https: 443,
    }
]