class CustomersController < ApplicationController

before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

def show
    @customer = Customer.find(params[:id])
  end

  def index
     #@customers = Customer.page(params[:page])
     @q = Customer.search(params[:q])
     @customers = @q.result.page(params[:page])
  end

  def new
     @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
    redirect_to @customer
  else
    render :new
  end
end

private

  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email
      )
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if  @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end

  end



  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_url

  end
end
