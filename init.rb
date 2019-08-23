Redmine::Plugin.register :redmine_sub_version do
  name 'Redmine Sub Version plugin'
  author 'Bilel kedidi'
  description 'This plugin create subversion for Version'
  version '0.0.2'
  url 'https://github.com/bilel-kedidi/redmine_sub_version'
  author_url 'https://github.com/bilel-kedidi/'


  settings :default => {'empty' => true}, :partial => 'subversions/settings'

end

require 'subversion_hook'
require 'redmine_subversion/versions_controller_patch'
require 'redmine_subversion/version_patch'
