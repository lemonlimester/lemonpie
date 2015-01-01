class Report
  attr_reader :category_id, :category_name, :amount
  attr_accessor :budget_amount

  def initialize(category_id, category_name, amount)
    @category_id = category_id
    @category_name = category_name
    @amount = amount
  end

  def self.generate(year, month)
    firstDayOfMonth = Date.new(year, month)
    lastDayOfMonth = Date.new(year, month, -1)

    budgets_hash = {}
    Budget.all.each { |b| budgets_hash[b.category_id] = b.amount }

    generated_reports = []
    categories = Category.all

    categories.each do |c|
      # find the budget set for this category
      expenses = Expense.where("category_id = ? AND date >= ? AND date < ?",
                  c.id, firstDayOfMonth, lastDayOfMonth)

      # calculate total for all expenses that belong to the given category in the given month
      subtotal = 0
      expenses.each { |e| subtotal += e.amount }

      report = Report.new(c.id, c.name, subtotal)
      report.budget_amount = budgets_hash[c.id] if budgets_hash.has_key?(c.id)
      generated_reports.push(report)
    end

    generated_reports
  end

end
