require File.dirname(__FILE__) + '/../test_helper'

require File.dirname(__FILE__) + '/../../app/controllers/failures_controller'
require 'shoulda/action_controller'

class FailuresControllerTest < ActionController::TestCase
  include Shoulda::ActionController::Macros
  
  fixtures :projects, :users, :roles, :members, :member_roles, :issues, :issue_statuses, :versions, :trackers,
           :projects_trackers, :issue_categories, :enabled_modules, :enumerations, :attachments, :workflows,
           :custom_fields, :custom_values, :custom_fields_projects, :custom_fields_trackers, :time_entries,
           :journals, :journal_details, :queries, :repositories, :changesets, :issue_relations

  def setup
    @controller = FailuresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 1 # admin
  end

  context "without admin privileges" do
    should "reject user" do
      @request.session[:user_id] = 2 # not admin
      get :index
      assert_response 403
    end
  end

  context "GET :index" do
    should "define a route for issue relations" do
      assert_routing(
        { :method => :get, :path => '/failures' },
        { :controller => 'failures', :action => 'index' }
      )
      assert_routing(
        { :method => :get, :path => '/failures/567' },
        { :controller => 'failures', :action => 'show', :id => '567' }
      )
    end

    should "display errors" do
      failure = Failure.create!(name: "ArgumentError", context: "", message: "blah")
      get :index
      assert_response :success
      assert_template "failures/index"
      assert assigns(:failures).include?(failure)
    end
  end
end
