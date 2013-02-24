class Failure < ActiveRecord::Base
  unloadable

  before_save :compute_signature

  def short_message
    "#{message}".split("\n").first.sub(Rails.root.to_s, "")
  end

  def compute_signature
    msg = short_message.gsub(/<([A-Z]\w+):0x\w+>/){ "<#{$1}:xxx>" }
    self.signature = "#{name}|#{msg}"
  end
end
