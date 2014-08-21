require "spec_helper"
require "active_support/testing/assertions"

describe "FailuresSubscriber" do
  include ActiveSupport::Testing::Assertions

  render_views

  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories,
           :projects_trackers,
           :queries,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :workflows

  before do
    @controller = NewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 2 #jsmith
  end

  it "should insert a failure" do
    News.stubs(:visible).raises(Exception.new("Bad robot"))
    assert_difference 'Failure.count' do
      assert_raises Exception do
        get :index
      end
    end
    failure = Failure.last
    assert failure.message.match /Bad robot/
    failure.login.should == "jsmith"
    failure.user_id.should == 2
    assert failure.backtrace.match(/\w+/)
  end

end
