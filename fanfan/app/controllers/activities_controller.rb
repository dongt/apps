class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end
  
  def show
    @activity = Activity.find(params[:id])
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    usernames = params[:activity].delete(:user_names).split(",")
    users = usernames.map{|n| User.find_by_name(n)}
    params[:activity][:users] = users
    @activity = Activity.new(params[:activity])
    if @activity.save
      flash[:notice] = "Successfully created activity."
      redirect_to @activity
    else
      render :action => 'new'
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:id])
    usernames = params[:activity].delete(:user_names).split(",")
    users = usernames.map{|n| User.find_by_name(n)}
    params[:activity][:users] = users
    if @activity.update_attributes(params[:activity])
      flash[:notice] = "Successfully updated activity."
      redirect_to @activity
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = "Successfully destroyed activity."
    redirect_to activities_url
  end
end