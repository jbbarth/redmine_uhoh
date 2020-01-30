RedmineApp::Application.routes.draw do
  resources 'failures', only: %i[index show update]
end
