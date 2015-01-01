class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.datetime :date
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
