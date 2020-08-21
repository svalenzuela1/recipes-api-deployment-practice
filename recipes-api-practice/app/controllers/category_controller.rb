class CategoryController < ApplicationController
  #index responsible for GET request
  def index
    @category_list = Category.all

    #checking to see that we DON'T have an empty table
    if @category_list.empty?
      render json:{
          'error': "ERROR: There's no data to show!!"
      }
    else
      render :json => {
          :response => "successful",
          :data => @category_list
      }
      #end of if statement
    end
    #end of index function
  end

  #create is responsible for Post requests
  def create
    @one_category = Category.new(category_params)
    if @one_category.save
      render :json => {
          :response => 'Category List has been created',
          :data => @one_category
      }
      else
      render :json => {
          :error => "ERROR: Data cannot be saved"
      }
      #end of if statement
    end
    #end of create function
  end

  #This is a get request but shows only one By ID
  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'SHOW WORKS',
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'ERROR: Not Found'
      }
      #end of if statement
    end
    #end of show function
  end

  #Responsible for PUT REQUEST: updates existing category
  def update
    if(@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'Data successfully updated',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'ERROR: Unable to update'
      }
      #end of if statement
    end
    #end of update function
  end

  #Responsible for Delete request
  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
      render :json => {
          :response => 'Data Successfully Destroyed'
      }
    else
      render :json => {
          :response => 'ERROR: Not able to destroy'
      }
      #end of if statement
    end
    #end of destroy
  end

  private
  def category_params
    params.permit(:id, :title, :description, :created_by)
  end
end
