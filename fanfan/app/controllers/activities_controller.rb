class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
    @users = User.find(:all)
  end

  def create
    #usernames = params[:activity].delete(:user_names).split(",")
    #users = usernames.map{|n| User.find_by_name(n)}
    #params[:activity][:users] = users
    debugger
    payments = params[:activity][:payments].inject([]){|r,i| r[-1].is_a?(String) ?  r<<(Payment.new(:user_id => r.pop().to_i, :amount => i)) : r<<i}

    params[:activity][:payments] = payments

    @activity = Activity.new(params[:activity])

    @activity.status='new'
    if @activity.save
      flash[:notice] = "Successfully created activity."
      redirect_to @activity
    else
      @users=User.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @users = User.find(:all)
  end

  def update
    debugger
    @activity = Activity.find(params[:id])
    payments = params[:activity][:payments].inject([]){|r,i| r[-1].is_a?(String) ?  r<<(Payment.new(:user_id => r.pop().to_i, :amount => i)) : r<<i}
    debugger
    params[:activity][:payments] = payments
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
