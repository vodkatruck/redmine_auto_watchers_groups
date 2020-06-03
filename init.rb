require 'redmine'

require_dependency 'auto_watchers_groups'

Redmine::Plugin.register :redmine_auto_watchers_from_groups do
  name 'Redmine Auto Watchers Groups plugin'
  author 'vodkathuck'
  description 'Automatically add group members as issue watchers'
  version 'Sometime work'
  url 'https://example.com'
  author_url 'http://laduga.com'

  settings :default => {
    'groups_enabled' => []
  }, :partial => 'settings/auto_watchers_groups'
end
