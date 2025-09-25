require 'redmine'
require_relative 'lib/redmine_uhoh/hooks'

Redmine::Plugin.register :redmine_uhoh do
  name 'Redmine Uhoh plugin'
  description 'This plugin keeps track of your exceptions inside Redmine'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  version '6.0.7'
  url 'https://github.com/jbbarth/redmine_uhoh'
  requires_redmine :version_or_higher => '3.0.0'
  requires_redmine_plugin :redmine_base_rspec, :version_or_higher => '0.0.3' if Rails.env.test?
end

Redmine::MenuManager.map :admin_menu do |menu|
  menu.push :failures, {:controller => :failures},
            :caption => :label_failure_plural,
            :icon => 'warning',
            :html => {:class => 'icon icon-warning'}
end

# Support for Redmine 5
if Redmine::VERSION::MAJOR < 6
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
