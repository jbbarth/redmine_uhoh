require "spec_helper"

describe "Failure" do
  fixtures :users

  it "should #short_message" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails")
    expect(failure.short_message).to eq "/blah:57 hi"
  end

  it "should #long_message" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails",
                              :backtrace => "backbacktrace")
    expect(failure.long_message).to eq "/blah:57 hi\ndetails\nbackbacktrace"
  end

  it "should #signature" do
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    expect(failure.signature).to eq "Exception|blah:57 hi <Model:xxx> foo"
  end

  it "should #acknowledge!" do
    User.current = User.find(1)
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    assert !failure.acknowledged?
    failure.acknowledge!
    assert failure.acknowledged?
    expect(failure.acknowledged_user).to eq User.current
  end

  it "should #not_acknowledged scope" do
    failure1 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => false)
    failure2 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => true)
    assert Failure.not_acknowledged.include?(failure1)
    assert !Failure.not_acknowledged.include?(failure2)
  end
end