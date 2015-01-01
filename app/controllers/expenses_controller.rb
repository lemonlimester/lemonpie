class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @filters = {}
    @expenses = Expense.all
    @subtotal = calculate_subtotal(@expenses)

    render :index
  end

  # GET /expenses/today
  def today
    @filters = { :date => Date.today.to_s }

    @expenses = Expense.where(@filters)
    @subtotal = calculate_subtotal(@expenses)

    render :daily
  end

  # GET /expenses/daily/2014-10-25
  def daily
    @filters = params.permit(:date)
    @filters.each { |k, v| @filters.delete(k) if v.empty? }

    @expenses = Expense.where(@filters)
    @subtotal = calculate_subtotal(@expenses)

    render :daily
  end

  def filter
    @filters = params.permit(:category_id, :date)
    @filters.each { |k, v| @filters.delete(k) if v.empty? }

    @expenses = Expense.where(@filters)
    @subtotal = calculate_subtotal(@expenses)

    render :index
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:date, :description, :amount, :category_id)
    end

    def calculate_subtotal(theExpenses)
      total = 0
      theExpenses.each { |e| total += e.amount }

      total
    end
end
