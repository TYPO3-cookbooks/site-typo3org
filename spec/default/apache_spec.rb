require 'spec_helper'

describe 'server setup' do
  describe service('apache2') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(8080) do
    it { should be_listening }
  end

  describe command('sudo apache2ctl -t') do
    # lint config files
    its(:exit_status) { should eq 0 }
  end

  describe command('sudo apache2ctl -t -D DUMP_MODULES')  do
    %w{ alias dir env expires fcgid headers mime negotiation rewrite rpaf setenvif suexec }.each do |mod|
      its(:stdout) { should match /^\s*#{mod}_module\s+/i }
    end
  end
end

describe 'user' do
  describe user('typo3org') do
    it { should exist }
    it { should belong_to_group 'www-data' }
  end
end

describe 'application website' do
  describe file('/var/www/vhosts/typo3.org/') do
    it { should be_directory }
  end
end