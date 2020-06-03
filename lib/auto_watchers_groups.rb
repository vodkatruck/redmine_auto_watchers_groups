module AutoWatchersFromGroups
        class Hooks < Redmine::Hook::ViewListener
                def controller_issues_new_after_save(context)
                        auto_watchers(context)
                end
                def controller_issues_edit_before_save(context)
                        auto_watchers(context)
                end
                def auto_watchers(context)
                        @settings ||= Setting.plugin_redmine_auto_watchers_from_groups
                        @issue = Issue.find context[:issue][:id]
                        grom = 1
                        for grom in 1..100
                                group_id = "#{grom}"
                                if @settings['groups_enabled'].include? group_id
                                        group = Group.find group_id
                                        group.users.each do |new_watcher|
                                                Watcher.create(:watchable => @issue, :user => new_watcher)
                                        end
                                end
                        end
                end
                alias_method :controller_issues_bulk_edit_before_save, :controller_issues_edit_before_save
        end 
end