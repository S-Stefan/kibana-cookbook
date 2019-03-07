include_recipe "apt"

bash "wget_get" do
  code "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -"
end

package "apt-transport-https" do
  action :install
end

bash "get_elastic_sourceslist" do
  code 'echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list'
end

apt_update "update" do
  action :update
end

package "kibana" do
  action :install
end

template "/etc/kibana/kibana.yml" do
  source "kibana.yml"
  notifies :restart, "service[kibana]"
end

link '/etc/kibana/kibana.yml' do
  to 'kibana.yml'
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  notifies :restart, "service[nginx]"
end

service "nginx" do
  action [:enable, :start]
end

service 'kibana' do
  action [:start, :enable]
end
