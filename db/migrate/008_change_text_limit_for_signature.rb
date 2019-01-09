class ChangeTextLimitForSignature < ActiveRecord::Migration[4.2]
  def change
    change_column :failures, :signature, :text, :limit => nil
  end
end
