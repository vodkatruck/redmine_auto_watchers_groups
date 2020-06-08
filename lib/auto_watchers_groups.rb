module AutoWatchersGroups
        class Hooks < Redmine::Hook::ViewListener
                def controller_issues_new_after_save(context)
                        auto_watchers(context)
                end
                def controller_issues_edit_before_save(context)
                        auto_watchers(context)
                end
                def auto_watchers(context)
                        @settings ||= Setting.plugin_redmine_auto_watchers_groups
                        @issue = Issue.find context[:issue][:id]
                        Role.all.sort.each do |role|
                                if @settings['roles_enabled'].include? "#{role.id}"
                                        role.members.each do |member|
                                                if member.project_id == @issue.project_id
                                                        Group.all.sort.each do |group|
                                                                if @settings['groups_enabled'].include? "#{group.id}"
                                                                        group.users.each do |user|
                                                                                if member.user_id == user.id
                                                                                        Watcher.create(:watchable => @issue, :user => user)
                                                                                end
                                                                        end
                                                                end
                                                        end
                                                end
                                        end
                                        end
                                end
                        end
                end
                alias_method :controller_issues_bulk_edit_before_save, :controller_issues_edit_before_save
        end

end

