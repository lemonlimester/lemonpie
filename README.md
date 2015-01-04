# Expense App
The Expense app is an application to record daily expenses.
It currently consists of two main views: daily expenses and monthly expenses.

## The Daily View
* This view shows all the expense records for the selected date.
* Each expense has a category, a description, and an amount.
* The user is able to add a new expense record, update and delete the existing records.

## The Monthly View
* This view shows the monthly spending for each category.
* Additionally, it shows the budget set for each category and the difference with the actual spending.
* The user is able to update each budget amount.

## Models
The Expense app consists of the following tables:
* expenses
  This table keeps all the expense records. Each expense has id, date, category id, description, and amount attributes.
  This table is accessed using the Expense class which inherits from the ActiveRecord::Base class.

* categories
  This table keeps all the categories. Each category has id and name attributes.
  This table is accessed using the Category class which inherits from the ActiveRecord::Base class.

* budgets
  This table keeps all the budgets. Each budget has id, category id and budget amount attributes.
  This table is accessed using the Budget class which inherits from the ActiveRecord::Base class.

Additionally, Report class was created as the model for the monthly view. It has category id, category name, monthly spending for the category, and budget amount attributes. The class populates the reports using the queries provided by the Expense, Category, and Budget classes.

## Controllers
The Expense app consists of the following controllers:
* ExpensesController
  This controller handles the GET, POST, PATCH, PUT and DELETE requests for the expenses.

* CategoriesController
  This controller currently only handles the POST request to create a new category.

* BudgetsController
  This controller currently only handles the POST request to create or update multiple budgets based on the given category id (NOT the budget id). For each of the given category id, it will check if budget has been created before. If it is, the respective budget record will be updated. Otherwise, a new budget record will be added.

* ReportsController
  This controller currently only handles the GET request to show monthly spending for each category for the given month.

