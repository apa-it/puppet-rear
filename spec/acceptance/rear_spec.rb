require 'spec_helper_acceptance'

describe 'rear' do
  let(:manifest) {
    <<-CLASSPARAMETER
class { 'rear':
  output_url        => 'nfs://192.168.1.20/srv/rear',
  backup_url        => 'nfs://192.168.1.20/srv/rear',
  backup_schedule   => 'weekly',
  ssh_root_password => 'Recover!1234',
}
CLASSPARAMETER
  }

  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end

  it 'should apply a second time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end

  describe file('/etc/rear/local.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/etc/cron.d/rear') do
    it { should be_file }
    it { should exist }
  end

  describe package('rear') do
    it { should be_installed }
  end
end
