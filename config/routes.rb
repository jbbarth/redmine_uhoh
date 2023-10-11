RedmineApp::Application.routes.draw do
  resources 'failures', :only => [:index, :show, :update] do
    collection do
      get 'raise_exception'
    end
  end
end
