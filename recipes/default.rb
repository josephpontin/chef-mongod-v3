#
# Cookbook:: mongod_cookbook
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# apt_repository 'mongodb' do
#   uri        'http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse'
#   components ['mongodb']
# end
#
# package 'mongodb'

# include_recipe "sc-mongodb::default"


bash 'mongo_get_source' do
  code <<-EOH
    # key needed to access repo
    wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -

    # gets url of that source and adds to list
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

    # pulls from source
    # sudo apt-get update -y
    EOH
  end

apt_update

bash 'install_mongo' do
  code <<-EOH
    # installs
    sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
    EOH
  end

# package 'mongodb-org=3.2.20' do
#   action :install
# end


service 'mongod' do
  action [:start, :enable]
end
