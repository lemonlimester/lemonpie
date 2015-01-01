class BudgetsController < ApplicationController

  # POST /budgets
  # POST /budgets.json
  def create
    budget_params = retrieve_params_from_single_request
    results = Budget.where(category_id: budget_params[:category_id])

    if results.any?
      @budget = results.first

      respond_to do |format|
        if @budget.update(budget_params)
          format.json { render :show, status: :ok, location: @budget }
        else
          format.json { render json: @budget.errors, status: :unprocessable_entity }
        end
      end
    else
      @budget = Budget.new(budget_params)
      respond_to do |format|
        if @budget.save
          format.json { render :show, status: :created, location: @budget }
        else
          format.json { render json: @budget.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST /budgets/multi.json
  def create_multi
    all_updated = true
    responses = []

    multi_budget_params = params.require(:budgets)
    multi_budget_params.each do |key, value|
      succeed, response = create_or_update(value)
      responses.push(response)

      all_updated = all_updated and succeed
    end

    respond_to do |format|
      if all_updated
        format.json { render json: responses, status: :created }
      else
        format.json { render json: responses, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def retrieve_params_from_single_request
      params.require(:budget).permit(:category_id, :amount)
    end

    def create_or_update(budget_params)
      succeed = false;
      response = {}

      results = Budget.where(category_id: budget_params[:category_id])

      if results.any?
        @budget = results.first
        succeed = @budget.update(budget_params)
      else
        @budget = Budget.new(budget_params)
        succeed = @budget.save
      end

      if succeed
        response = {
            :budget => {
              :category_id => @budget.category_id,
              :amount => @budget.amount,
              :created_at => @budget.created_at,
              :updated_at => @budget.updated_at
            }
        }
      else
        response = {
          :errors => @budget.errors
        }
      end

      return succeed, response

    end
end
