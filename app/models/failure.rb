# Failure model
class Failure < ActiveRecord::Base
  unloadable
  belongs_to :acknowledged_user, class_name: 'User', foreign_key: 'acknowledged_user_id'

  before_save :compute_signature

  attr_accessible :name, :message, :acknowledged, :backtrace, :acknowledged_user_id, :path

  scope :not_acknowledged, -> { where(acknowledged: false) }

  def short_message
    message.to_s.split("\n").first.sub(Rails.root.to_s, '')
  end

  def long_message
    "#{message}\n#{backtrace}".gsub(Rails.root.to_s, '')
  end

  def url
    path.to_s
  end

  def compute_signature
    msg = short_message.gsub(/<([A-Z]\w+):0x\w+>/) { "<#{Regexp.last_match(1)}:xxx>" }
    self.signature = "#{name}|#{msg}"
  end

  def acknowledge!
    update_attributes(acknowledged: true,
                      acknowledged_user_id: User.current.id)
  end

  def acknowledge_similar_failures
    Failure.where(signature: signature)
           .update_all(acknowledged: true, acknowledged_user_id: User.current.id)
  end

  def acknowledge_all_failures
    Failure.update_all(acknowledged: true, acknowledged_user_id: User.current.id)
  end
end
