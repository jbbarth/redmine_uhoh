# add acknowledged columns
class AddAcknowledgedToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :failures, :acknowledged, :boolean, default: false
    add_column :failures, :acknowledged_user_id, :integer
  end
end
