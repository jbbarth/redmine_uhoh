module RedmineUhoh
  # inject css
  class Hooks < Redmine::Hook::ViewListener
    # adds our css on each page
    def view_layouts_base_html_head(context)
      admin_layout = begin
                       context[:controller].send(:_layout) == 'admin'
                     rescue StandardError
                       true
                     end
      stylesheet_link_tag('uhoh', plugin: 'redmine_uhoh') if admin_layout
    end
  end
end
