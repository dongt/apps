class ActivitiesController < ApplicationController
  def index
    @rows = (params[:rows]||10).to_i
    @page = (params[:page]||1).to_i
    @sort = params[:sord]||'desc'
    @sidx = params[:sidx]||'id'

    if params[:_search] == 'true'
      field = params[:searchField]
      value = params[:searchString]
      oper  = { "eq" => "=","lt" => "<"}[params[:searchOper]]||'like'
      conditions = "#{field} #{oper} '#{value}'"
    end
    @total = Activity.count
    if conditions
      @activities = Activity.find(:all,:limit => @rows,:offset => @rows*(@page.to_i-1),:order => "#{@sidx} #{@sort}", conditions.nil? ? nil:conditions => [conditions] )
    else
      @activities = Activity.find(:all,:limit => @rows,:offset => @rows*(@page.to_i-1),:order => "#{@sidx} #{@sort}" )
    end

    respond_to do |format|
      format.html
      format.xml { params[:from] == "jqgrid" ? (render :action => "list.rxml") : (render :xml => @activities)}
    end
  end

  def show
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @activity}
    end
  end

  def new
    @activity = Activity.new
    @users = User.find(:all)
  end

  def create
    #usernames = params[:activity].delete(:user_names).split(",")
    #users = usernames.map{|n| User.find_by_name(n)}
    #params[:activity][:users] = users

    params[:activity][:payments] = get_payments

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
    @activity = Activity.find(params[:id])

    params[:activity][:payments] = get_payments
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

  private
  def get_payments
    payments = params[:activity][:payments].inject([]){|r,i| r[-1].is_a?(String) ?  r<<(Payment.new(:user_id => r.pop().to_i, :amount => i)) : r<<i}
    return payments if payments.size <= 1
    total = payments[0].amount
    average = payments[0].amount/payments.size

    #other payed
    other_total = payments[1..-1].inject(0){ |sum,i| sum += i.amount}
    payments[0].amount = total - other_total
    payments
  end
end
