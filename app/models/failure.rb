class Failure < ActiveRecord::Base
  unloadable

  def short_message
    "#{message}".split("\n").first.sub(Rails.root.to_s, "")
  end
end
