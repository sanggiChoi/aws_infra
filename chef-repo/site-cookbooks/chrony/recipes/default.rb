# frozen_string_literal: true
# This is a Chef recipe file. It can be used to specify resources which will
# apply configuration to a server.

yum_package 'ntp*' do
  action :remove
end

yum_package 'chrony' do
  action :install
end

service 'chronyd' do
  action [ :enable, :start ]
  retries 3
end
