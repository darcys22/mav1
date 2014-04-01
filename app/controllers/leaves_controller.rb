class LeavesController < ApplicationController
  respond_to :html, :js

  def index
    @leaves = Leave.all
    @leaves = Leave.between(params['start'], params['end']) if (params['start'] && params['end'])
  end

  def show
    @leave = Leave.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @leave }
    end
  end

  def new
    @leave = Leave.new(:start => params[:start], :finish => params[:end])
    @employees = Employee.all
  end

  def edit
    @leave = Leave.find(params[:id])
    @employees = Employee.all
    @deletable = true
  end

  def create
    @leave = Leave.new(leave_params)

    respond_to do |format|
      if @leave.save
        format.html { render :action => "index", :notice => 'Day off was successfully recorded' }
        format.json { render :json => @leave, :status => :created, :location => @leave }
      else
        format.html { render :action => "new" }
        format.json { render :json => @leave.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @leave = Leave.find(params[:id])

    respond_to do |format|
      if @leave.update_attributes(leave_params)
        format.html { redirect_to @leave, :notice => 'Day off was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @leave.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @leave = Leave.find(params[:id])
    @leave.destroy

    respond_to do |format|
      format.html { redirect_to leaves_url }
      format.json { head :no_content }
    end
  end


  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def leave_params
      params.required(:leave).permit(:start, :finish, :employee_id, :start_human, :finish_human)
    end
end
