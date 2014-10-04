#
# Varnish Cache in front of Apache
#

package 'varnish'

template node['varnish']['default'] do
  source node['varnish']['conf_source']
  cookbook node['varnish']['conf_cookbook']
  owner 'root'
  group 'root'
  mode 0644
end

%w{ varnish varnishlog varnishncsa }.each do |name|
  file "/etc/init.d/#{name}" do
    action :delete
  end
end


node['site-typo3org']['varnish']['vhosts'].each do |conf|

  template "#{node['varnish']['default']}-#{conf.name}" do
    source 'varnish/default.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(conf: conf)
#    notifies :reload, 'service[varnish]'
  end

  template "#{node['varnish']['dir']}/#{conf.name}.vcl" do
    source 'varnish/default.vcl.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(conf: conf)
#    notifies :reload, 'service[varnish]'
  end

  %w{ varnish varnishlog varnishncsa }.each do |name|
    template "/etc/init.d/#{name}-#{conf.name}" do
      source "varnish/#{name}.d.erb"
      owner 'root'
      group 'root'
      mode 0755
      variables(conf: conf)
    end
  end

  %w{ varnish varnishlog }.each do |name|
    service "#{name}-#{conf.name}" do
      supports restart: true, reload: true
      action %w(enable start)
    end
  end

end



