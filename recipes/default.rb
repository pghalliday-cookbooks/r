mirror = node['r']['mirror']
case node["platform"]
when "ubuntu"
  apt_repository 'r' do
    uri "#{mirror}/bin/linux/ubuntu"
    distribution "#{node['lsb']['codename']}/"
    keyserver 'keyserver.ubuntu.com'
    key 'E084DAB9'
  end
  package 'r-base'
  package 'r-base-dev'
when "centos"
  include_recipe 'yum-epel::default'
  package 'R'
end
