# add backtrace
class AddBacktraceToFailures < ActiveRecord::Migration
  def change
    add_column :failures, :backtrace, :text
  end
end
