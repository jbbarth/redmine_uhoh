require File.dirname(__FILE__) + '/../test_helper'

class FailureTest < ActiveSupport::TestCase
  test "#short_message" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails")
    assert_equal "/blah:57 hi", failure.short_message
  end
end
