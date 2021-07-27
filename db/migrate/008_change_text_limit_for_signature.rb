# signature limit removal
class ChangeTextLimitForSignature < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    change_column :failures, :signature, :text, limit: nil
  end
end
