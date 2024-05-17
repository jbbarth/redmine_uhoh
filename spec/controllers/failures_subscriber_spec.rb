require "spec_helper"
require "active_support/testing/assertions"

describe "FailuresSubscriber", type: :controller do
  include ActiveSupport::Testing::Assertions

  render_views

  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories, :email_addresses,
           :projects_trackers,
           :queries,
           :roles, :members, :member_roles,
           :enabled_modules, :workflows,
           :comments, :news, :attachments

  before do
    @controller = NewsController.new
    @request = ActionDispatch::TestRequest.create
    @response = ActionDispatch::TestResponse.new
    User.current = User.find(1)
    @request.session[:user_id] = 1 # admin
  end

  it "should insert a failure" do
    allow(News).to receive(:visible).and_raise(Exception.new("Bad robot"))
    expect do
      assert_raises Exception do
        get :index
      end
    end.to change { Failure.count }
    failure = Failure.last
    expect(failure.message).to match /Bad robot/
    expect(failure.login).to eq "admin"
    expect(failure.user_id).to eq 1
    expect(failure.backtrace).to match /\w+/
    # expect(failure.path).to eq "/news"
  end

end
