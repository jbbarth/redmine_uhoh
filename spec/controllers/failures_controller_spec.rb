require "spec_helper"

require File.dirname(__FILE__) + '/../../app/controllers/failures_controller'

describe FailuresController do
  fixtures :projects, :users, :roles, :members, :member_roles, :issues, :issue_statuses, :versions, :trackers,
           :projects_trackers, :issue_categories, :enabled_modules, :enumerations, :attachments, :workflows,
           :custom_fields, :custom_values, :custom_fields_projects, :custom_fields_trackers, :time_entries,
           :journals, :journal_details, :queries, :repositories, :changesets, :issue_relations

  before do
    @controller = FailuresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 1 # admin
  end

  context "without admin privileges" do
    it "should reject user" do
      @request.session[:user_id] = 2 # not admin
      get :index
      assert_response 403
    end
  end

  context "GET :index" do
    it "should define a route" do
      assert_routing(
        { :method => :get, :path => '/failures' },
        { :controller => 'failures', :action => 'index' }
      )
    end

    it "should display errors" do
      failure = Failure.create!(name: "ArgumentError", context: "", message: "blah")
      get :index
      response.should be_success
      assert_template "failures/index"
      assert assigns(:failures).include?(failure)
    end
  end

  context "GET :show" do
    it "should define a route" do
      assert_routing(
        { :method => :get, :path => '/failures/567' },
        { :controller => 'failures', :action => 'show', :id => '567' }
      )
    end

    it "should display a failure" do
      failure = Failure.create!(name: "ArgumentError", context: "", message: "blah")
      get :show, :id => failure.id
      response.should be_success
      assert_template "failures/show"
      assigns(:failure).should == failure
    end
  end

  context "PUT :update" do
    before do
      @failure = Failure.create!(name: "ArgumentError", context: "ctx", message: "blah")
    end

    it "should acknowledge failure if parameter is passed" do
      put :update, :id => @failure.id, :acknowledged => "1"
      response.should redirect_to("/failures")
      assert @failure.reload.acknowledged?
    end

    it "should not accept updates on any other parameter" do
      old_attributes = @failure.attributes
      put :update, :id => @failure.id, :failure => { :name => "Blah", :context => "Foo" }
      response.should redirect_to("/failures")
      @failure.reload
      %w(name context message signature acknowledged acknowledged_user_id).each do |key|
        @failure.attributes[key].should == old_attributes[key]
      end
    end
  end
end
