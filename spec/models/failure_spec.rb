require "spec_helper"

describe "Failure" do
  fixtures :users

  describe "#short_message method" do
    it "should #short_message" do
      failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails")
      expect(failure.short_message).to eq "/blah:57 hi"
    end

    it "does not through an exception if it receives an empty message" do
      failure = Failure.create!(:message => "")
      expect(failure.short_message).to eq ""
    end
  end

  describe "#long_message method" do
    it "should #long_message" do
      failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails",
                                :backtrace => "backbacktrace")
      expect(failure.long_message).to eq "/blah:57 hi\ndetails\nbackbacktrace"
    end

    it "does not through an exception if it receives an empty message" do
      failure = Failure.create!(:message => "",
                                :backtrace => "backbacktrace")
      expect(failure.long_message).to eq "\nbackbacktrace"
    end
  end

  it "should #signature" do
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    expect(failure.signature).to eq "Exception|blah:57 hi <Model:xxx> foo"
  end

  it "should #url" do
    failure = Failure.create!(:message => "#{Rails.root}/blah:57 hi\ndetails", :path => "/details")
    expect(failure.url).to eq "/details"
  end

  it "should #acknowledge!" do
    User.current = User.find(1)
    failure = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    assert !failure.acknowledged?
    failure.acknowledge!
    assert failure.acknowledged?
    expect(failure.acknowledged_user).to eq User.current
  end

  it "should #acknowledge_similar_failures" do
    User.current = User.find(1)
    failure1 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    failure2 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4254152> foo\ndifferent details")
    failure3 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x123456789> foo\ndetails")
    failure4 = Failure.create!(:name => "Exception", :message => "blouh:54 hi I'm an other kind of error <Model:0x5748759> foo\ndetails")
    assert !failure1.acknowledged?
    assert !failure2.acknowledged?
    assert !failure3.acknowledged?
    assert !failure4.acknowledged?
    failure2.acknowledge_similar_failures
    assert failure1.reload.acknowledged?
    assert failure2.reload.acknowledged?
    assert failure3.reload.acknowledged?
    assert !failure4.reload.acknowledged?
    expect(failure1.acknowledged_user).to eq User.current
  end

  it "should #acknowledge_similar_failures" do
    User.current = User.find(1)
    failure1 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4234c453> foo\ndetails")
    failure2 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x4254152> foo\ndifferent details")
    failure3 = Failure.create!(:name => "Exception", :message => "blah:57 hi <Model:0x123456789> foo\ndetails")
    failure4 = Failure.create!(:name => "Exception", :message => "blouh:54 hi I'm an other kind of error <Model:0x5748759> foo\ndetails")
    assert !failure1.acknowledged?
    assert !failure2.acknowledged?
    assert !failure3.acknowledged?
    assert !failure4.acknowledged?
    failure2.acknowledge_all_failures
    assert failure1.reload.acknowledged?
    assert failure2.reload.acknowledged?
    assert failure3.reload.acknowledged?
    assert failure4.reload.acknowledged?
    expect(failure4.acknowledged_user).to eq User.current
  end

  it "should #not_acknowledged scope" do
    failure1 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => false)
    failure2 = Failure.create!(:name => "Exception", :message => "blah:57", :acknowledged => true)
    assert Failure.not_acknowledged.include?(failure1)
    assert !Failure.not_acknowledged.include?(failure2)
  end
end
