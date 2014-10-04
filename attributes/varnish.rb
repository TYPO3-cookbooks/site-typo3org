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