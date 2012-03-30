#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
# Cookbook Name:: java
# Recipe:: apple
#
# Copyright 2008-2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case
when Chef::VersionConstraint.new("~> 10.7.0").include?(node.platform_version)
  pk_volumes_dir = "Java for Mac OS X 10.7"
  pk_app = "JavaForMacOSX10.7"
  pk_package_id = "com.apple.pkg.JavaForMacOSX107"
when Chef::VersionConstraint.new("~> 10.6.0").include?(node.platform_version)
  pk_volumes_dir = "Java for Mac OS X 10.6"
  pk_app = "JavaForMacOSX10.6"
  pk_package_id = "com.apple.pkg.JavaForMacOSX106"
end

dmg_package "Java-6" do
  app pk_app
  package_id pk_package_id
  volumes_dir pk_volumes_dir
  source node['java']['jdk']['6']['x86_64']['url']
  checksum node['java']['jdk']['6']['x86_64']['checksum']
  type "pkg"

  action :install
end

ruby_block "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = node['java']['java_home']
  end
end
