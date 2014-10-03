require 'spec_helper'

describe service('apache2') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe command('sudo apache2ctl -t -D DUMP_MODULES')  do

  %w{ alias dir env expires fcgid headers mime negotiation rewrite setenvif suexec }.each do |mod|
    its(:stdout) { should match /^\s*#{mod}_module\s+/i }
  end
end