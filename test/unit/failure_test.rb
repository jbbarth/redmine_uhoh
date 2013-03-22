require File.dirname(__FILE__) + '/../test_helper'

class FailureTest < ActiveSupport::TestCase
  fixtures :users

  test "#short_message" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails")
    assert_equal "/blah:57 hi", failure.short_message
  end

  test "#signature" do
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    assert_equal "Exception|blah:57 hi <Model:xxx> foo", failure.signature
  end

  test "#acknowledge!" do
    User.current = User.find(1)
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    assert !failure.acknowledged?
    failure.acknowledge!
    assert failure.acknowledged?
    assert_equal User.current, failure.acknowledged_user
  end

  test "#not_acknowledged scope" do
    failure1 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => false)
    failure2 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => true)
    assert Failure.not_acknowledged.include?(failure1)
    assert !Failure.not_acknowledged.include?(failure2)
  end
end
