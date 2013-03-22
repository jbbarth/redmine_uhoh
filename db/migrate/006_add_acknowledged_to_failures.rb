class AddAcknowledgedToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :acknowledged, :string
    add_column :failures, :acknowledged_user_id, :integer
  end
end
