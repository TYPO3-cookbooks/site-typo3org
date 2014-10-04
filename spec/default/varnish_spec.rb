require 'spec_helper'

describe 'server setup' do
  describe service('varnish-production') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(80) do
    it { should be_listening }
  end

end

describe 'server configuration' do
  describe file('/etc/varnish/production.vcl') {
    it { should be_file }
  }

  describe command('sudo varnishd -C -f /etc/varnish/production.vcl') do
    its(:stderr) { should eq '' }
  end
end