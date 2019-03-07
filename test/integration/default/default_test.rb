# # encoding: utf-8

# Inspec test for recipe kibana::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end


describe package "kibana" do
  it { should be_installed }
end

describe service "kibana" do
  it { should be_running }
  it { should be_enabled }
end

describe file('/etc/kibana/kibana.yml') do
  it { should be_symlink }
end

describe service "nginx" do
  it { should be_enabled }
  it { should be_running}
end

describe file('/etc/nginx/nginx.conf') do
  its (:content) { should match /localhost:5601/ }
end



# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should be_listening }
end
