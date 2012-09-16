require 'redmine_uhoh/subscriber'

Redmine::Plugin.register :redmine_uhoh do
  name 'Redmine Uhoh plugin'
  description 'This plugin keeps track of your exceptions inside Redmine'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_uhoh'
  requires_redmine :version_or_higher => '2.0.0'
end
