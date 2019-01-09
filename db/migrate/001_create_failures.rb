class CreateFailures < ActiveRecord::Migration[4.2]
  def change
    create_table :failures do |t|
      t.string :name
      t.text :context
      t.text :message
    end
  end
end
