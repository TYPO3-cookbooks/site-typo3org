# site-typo3org-cookbook

Installs/Configures typo3.org

## Development

I had to get the Vagrantfile to work with Vagrant 1.4, but vagrant-berkshelf does not seem to compatible. That's why
you need to *vendor* the cookbooks manually before provisioning

    rm -rf cookbooks && berks vendor cookbooks
    vagrant up --provision