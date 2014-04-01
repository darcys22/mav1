class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def edit
      #@employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render action: 'index', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def import
      if request.post?
          Employee.import(params[:file])
          redirect_to employees_path, notice: "Employees imported."
      end
  end

  private
        # Use callbacks to share common setup or constraints between actions.
        def set_employee
          @employee = Employee.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def employee_params
          params.require(:employee).permit(:firstname, :lastname, :email, :monstart, :monfinish, :tuestart, :tuefinish, :wedstart, :wedfinish, :thurstart, :thurfinish, :fristart, :frifinish, :satstart, :satfinish, :sunstart, :sunfinish, :desired, :monstart_human, :monfinish_human, :tuestart_human, :tuefinish_human, :wedstart_human, :wedfinish_human, :thurstart_human, :thurfinish_human, :fristart_human, :frifinish_human, :satstart_human, :satfinish_human, :sunstart_human, :sunfinish_human)
        end
end
