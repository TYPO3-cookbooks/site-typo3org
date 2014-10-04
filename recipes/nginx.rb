#
# Nginx in front of Varnish to allow HTTPS
#

include_recipe 'nginx'

node['site-typo3org']['nginx']['vhosts'].each do |conf|
  template "#{node['nginx']['dir']}/sites-available/#{conf.name}.conf" do
    source 'nginx/proxy.conf.erb'
    owner 'root'
    group 'root'
    mode '0640'
    variables(conf: conf)

    if ::File.exist?("#{node['nginx']['dir']}/sites-available/#{conf.name}.conf")
      notifies :reload, 'service[nginx]', :delayed
    end
  end

  nginx_site "#{conf.name}.conf"
end