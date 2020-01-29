# signature limit removal
class ChangeTextLimitForSignature < ActiveRecord::Migration
  def change
    change_column :failures, :signature, :text, limit: nil
  end
end
