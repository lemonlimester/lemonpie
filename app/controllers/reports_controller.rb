class ReportsController < ApplicationController

  # GET /expenses/monthly/2014-10-01
  def show
    @report_date = Date.parse(params[:date])

    month = @report_date.month
    year = @report_date.year

    @reports = Report.generate(year, month)

    @report_months = get_report_months

    render :index
  end

  private
    def get_report_months
      list_of_dates = []

      if Expense.exists?
        minimumDate = Date.parse(Expense.minimum(:date).to_s)
        maximumDate = Date.parse(Expense.maximum(:date).to_s)

        first_day_of_month = Date.new(minimumDate.year, minimumDate.month);
        begin
          list_of_dates.push(first_day_of_month)
          first_day_of_month = first_day_of_month.next_month
        end while first_day_of_month <= maximumDate
      end

      list_of_dates

    end
end
