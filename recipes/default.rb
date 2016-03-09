#
# Cookbook Name:: compliance
# Recipe:: default
#
# Copyright 2016 Chef Software, Inc.
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

# fetch and execute all requested profiles
node['audit']['profiles'].each do |owner_profile, enabled|
  if enabled
    o, p = owner_profile.split('/')

    compliance_profile p do
      owner o
      action [:fetch, :execute]
    end
  end
end

# report the results
compliance_report 'chef-server' do
  node_owner 'admin' # XXX learn to do without
end if node['audit']['profiles'].values.any?
