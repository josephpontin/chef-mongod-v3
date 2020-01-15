# InSpec test for recipe mongod_cookbook::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/
# This is an example test, replace it with your own test.

describe port(27017) do
  it { should be_listening }
end

# describe file('/etc/apt/sources.list.d/mongodb-org-3.2.list') do
#   it { should exist }
# end

describe package('mongodb-org') do
  it { should be_installed }
  its('version') { should match /3\./ }
end

describe service('mongod') do
  it { should be_running }
  it { should be_enabled }
end
