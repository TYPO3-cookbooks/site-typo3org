require 'spec_helper'

describe 'server setup' do
  describe service('nginx') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(80) do
    it { should be_listening }
  end

end

describe 'server configuration' do
  describe file('/etc/nginx/sites-enabled/production.conf') {
    it { should be_file }
  }

  describe command('sudo nginx -t') do
    its(:exit_status) { should eq 0 }
  end
end