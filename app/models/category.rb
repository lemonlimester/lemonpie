class Category < ActiveRecord::Base
  has_many :expenses
  has_one :budget
end
