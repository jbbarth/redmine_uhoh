# add timestamps
class AddTimestampsToFailures < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    change_table :failures, &:timestamps
  end
end
