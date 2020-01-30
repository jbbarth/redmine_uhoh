# add acknowledged columns
class AddAcknowledgedToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :acknowledged, :boolean, default: false
    add_column :failures, :acknowledged_user_id, :integer
  end
end
