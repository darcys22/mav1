class LeavesController < ApplicationController
  before_action :set_leafe, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @leaves = Leave.scoped
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
  end

  def edit
    @leave = Leave.find(params[:id])
  end

  def create
    @leave = Leave.new(params[:event])

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
      if @leave.update_attributes(params[:event])
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
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
