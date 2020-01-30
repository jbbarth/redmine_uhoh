# add timestamps
class AddTimestampsToFailures < ActiveRecord::Migration
  def change
    change_table :failures, &:timestamps
  end
end
