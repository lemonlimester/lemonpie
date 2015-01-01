class CreateBudget < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.belongs_to :category, index: true
      t.decimal :amount

      t.timestamps
    end
  end
end
