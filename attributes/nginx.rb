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