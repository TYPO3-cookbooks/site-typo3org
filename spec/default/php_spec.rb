require 'spec_helper'

describe command('php -v') do
  its(:stdout) { should match /PHP 5\.[4-9]\./ }
end

describe command('php -m') do
  %w{curl gd mcrypt mysql redis xmlrpc xsl}.each do |mod|
    its(:stdout) { should match /^#{mod}$/i }
  end

end