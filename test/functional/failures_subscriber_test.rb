require File.expand_path('../../test_helper', __FILE__)
require 'active_support/log_subscriber/test_helper'
require 'action_controller/log_subscriber'

class FailuresSubscriberTest < ActionController::TestCase
  include ActiveSupport::LogSubscriber::TestHelper

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
    super #triggers ActiveSupport::LogSubscriber::TestHelper#setup
    @controller = NewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 2 #jsmith
    ActionController::LogSubscriber.attach_to(:action_controller)
  end

  def test_insert_a_failure
    News.stubs(:visible).raises(Exception.new("Bad robot"))
    assert_raises Exception do
      get :index
    end
    wait
    #doesn't work.. Failure is not inserted
    #TODO: find why!
    assert Failure.last.message.match /Bad robot/
  end
end
