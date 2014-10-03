
include_recipe 'php'

php_pear 'redis' do
  action :install
end