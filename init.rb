require 'redmine'
require 'redmine_cas'
require 'redmine_cas/application_controller_patch'
require 'redmine_cas/account_controller_patch'

require_dependency 'redmine_cas_hook_listener'

Redmine::Plugin.register :redmine_cas do
  name 'Redmine CAS'
  author 'Redouble117@Navigator fork from Nils Caspar (Nine Internet Solutions AG)'
  description '基于石刻Redmine平台，为平台增加单点登录功能，可以登录到CAS服务器。'
  version '2.02.01'
  url 'https://github.com/redouble/redmine_cas'
  author_url 'http://shike.in/'

  settings :default => {
    'enabled' => false,
    'cas_url' => 'https://localhost:8888',
    'attributes_mapping' => 'login=user&id=id&firstname=name',
    'autocreate_users' => false
  }, :partial => 'redmine_cas/settings'

  Rails.configuration.to_prepare do
    ApplicationController.send(:include, RedmineCAS::ApplicationControllerPatch)
    AccountController.send(:include, RedmineCAS::AccountControllerPatch)
  end
  ActionDispatch::Callbacks.before do
    RedmineCAS.setup!
  end
end
