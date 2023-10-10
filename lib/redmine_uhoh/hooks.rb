module RedmineUhoh
  class Hooks < Redmine::Hook::ViewListener
    #adds our css on each page
    def view_layouts_base_html_head(context)
      admin_layout = context[:controller].send(:_layout) == "admin" rescue true
      stylesheet_link_tag("uhoh", :plugin => "redmine_uhoh") if admin_layout
    end
  end

  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})
      require_relative 'subscriber'
    end
  end
end
