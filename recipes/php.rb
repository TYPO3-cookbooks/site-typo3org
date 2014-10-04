
include_recipe 'php'

php_pear 'redis' do
  action :install
end

package 'php5-cgi'

%w{ limits logging security }.each do |name|
  template "#{node['php']['ext_conf_dir']}/t3_#{name}.ini" do
    source "php_#{name}.ini.erb"
    owner 'root'
    group 'root'
    mode '00644'
  end
end

