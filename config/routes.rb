RedmineApp::Application.routes.draw do
  resources 'failures', :only => [:index, :show]
end
