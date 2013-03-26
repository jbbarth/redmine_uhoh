require File.expand_path('../../test_helper', __FILE__)

class FailuresSubscriberTest < ActionController::TestCase
  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories,
           :projects_trackers,
           :queries,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :workflows

  def setup
    @controller = NewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 2 #jsmith
  end

  def test_insert_a_failure
    News.stubs(:visible).raises(Exception.new("Bad robot"))
    assert_difference 'Failure.count' do
      assert_raises Exception do
        get :index
      end
    end
    failure = Failure.last
    assert failure.message.match /Bad robot/
    assert_equal "jsmith", failure.login
    assert_equal 2, failure.user_id
    assert failure.backtrace.match(/\w+/)
  end

end
