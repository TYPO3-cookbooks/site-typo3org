#
# Apache instance that serves TYPO3 pages from PHP
#

include_recipe 'site-typo3org::php'

include_recipe 'apache2'

package 'libapache2-mod-rpaf'
apache_module 'rpaf'

node['site-typo3org']['apache']['vhosts'].each do |conf|

  # create the user apache should run as
  if conf.user && conf.user != node['apache']['user']
    user conf.user do
      home conf.root_dir + '/home'
    end

    group node['apache']['group'] do
      members [conf.user]
      append true
      action :modify
    end
  end

  directory conf.root_dir do
    owner conf.user || node['apache']['user']
    group node['apache']['group']
    mode '00750'
    recursive true
  end

end

