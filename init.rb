require 'redmine'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine_uhoh/subscriber'
  require_dependency 'redmine_uhoh/hooks'
end

Redmine::Plugin.register :redmine_uhoh do
  name 'Redmine Uhoh plugin'
  description 'Keep track of raised exceptions within Redmine'
  author 'Jean-Baptiste BARTH (orig)'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  version '1.0.0'
  url 'https://github.com/tools-aoeur/redmine_uhoh'
  author_url 'https://github.com/tools-aoeur'
  requires_redmine version_or_higher: '2.0.0'
  requires_redmine_plugin :redmine_base_rspec, version_or_higher: '2.0.0' if Rails.env.test?
end

Redmine::MenuManager.map :admin_menu do |menu|
  menu.push :failures, { controller: :failures },
            caption: :label_failure_plural,
            html: { class: 'icon' }
end
