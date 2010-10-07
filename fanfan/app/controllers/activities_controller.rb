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
    cost=0
    payments = params[:activity][:payments].inject([]){|r,i| puts r;puts i; r[-1].is_a?(String) ?  r<<({'user_id' => r.pop().to_i, "amount" => i}) : r<<i}
   debugger
#     payers_params=params.keys.find_all{|key| key =~ /^payer\d+/}
#     if(payers_params)
#       payments = payers_params.map do |namek|
#         i=namek.match(/payer(\d+)/)[1]
#         amountk="payamount#{i}"
#         name=params[namek];
#         amount=params[amountk]
#         user=User.find_by_username(name)
#         payment=Payment.new(:amount=>amount)
#         payment.user=user;
#         payment.amount=amount;
#         cost += payment.amount
#         payment
#       end
#       params[:activity][:payments] = payments
#     end
    params[:activity][:payments] = payments

    @activity = Activity.new(params[:activity])
    @activity.cost=cost
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
