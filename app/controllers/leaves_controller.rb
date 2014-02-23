class LeavesController < ApplicationController
  before_action :set_leafe, only: [:show, :edit, :update, :destroy]

  def index
    @leaves = Leave.scoped
    @leaves = Leave.between(params['start'], params['end']) if (params['start'] && params['end'])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @leaves }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @leave = Leave.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @leave }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @leave = Leave.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @leave }
    end
  end

  # GET /events/1/edit
  def edit
    @leave = Leave.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @leave = Leave.new(params[:event])

    respond_to do |format|
      if @leave.save
        format.html { redirect_to @leave, :notice => 'Day off was successfully recorded' }
        format.json { render :json => @leave, :status => :created, :location => @leave }
      else
        format.html { render :action => "new" }
        format.json { render :json => @leave.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
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

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @leave = Leave.find(params[:id])
    @leave.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
