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
      home conf.home_root
    end

    group conf.user do
      members [conf.user]
      append true
    end

    group node['apache']['group'] do
      members [conf.user]
      append true
      action :modify
    end
  end

  [ conf.root_dir, conf.doc_root, conf.log_root, conf.home_root, conf.tmp_root, conf.fcgi_root ].each do |dir|
    directory dir do
      owner conf.user || node['apache']['user']
      group node['apache']['group']
      mode '00750'
      recursive true
    end
  end

  # create apache config
  template "#{node['apache']['dir']}/sites-available/#{conf.name}.conf" do
    source 'apache_site.conf.erb'
    owner 'root'
    group node['apache']['root_group']
    mode '0644'
    variables(conf: conf)

    if ::File.exist?("#{node['apache']['dir']}/sites-enabled/#{conf.name}.conf")
      notifies :reload, 'service[apache2]', :delayed
    end
  end

  apache_site conf.name

  # fastcgi wrapper
  template "#{conf.fcgi_root}/php-fcgi-starter" do
    source 'php_fastcgi_wrapper.erb'
    owner 'root'
    group node['apache']['root_group']
    mode '0755'
    variables(conf: conf)
  end

  directory "#{conf.fcgi_root}/conf" do
    owner conf.user || node['apache']['user']
    group node['apache']['group']
    mode '00750'
    recursive true
  end

  link "#{conf.fcgi_root}/conf/php.ini" do
    to "#{node['php']['conf_dir']}/../cgi/php.ini"
  end
  link "#{conf.fcgi_root}/conf/conf.d" do
    to "#{node['php']['conf_dir']}/../cgi/conf.d"
  end

  # configuration for this specific instance only
  # fastcgi wrapper
  template "#{conf.fcgi_root}/conf/php.ini" do
    source 'php_fastcgi_config.ini.erb'
    owner conf.user || node['apache']['user']
    group node['apache']['group']
    mode '00640'
    variables(conf: conf)
  end

end

