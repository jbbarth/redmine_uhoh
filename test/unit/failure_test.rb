require File.dirname(__FILE__) + '/../test_helper'

class FailureTest < ActiveSupport::TestCase
  test "#short_message" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails")
    assert_equal "/blah:57 hi", failure.short_message
  end

  test "#signature" do
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    assert_equal "Exception|blah:57 hi <Model:xxx> foo", failure.signature
  end
end
