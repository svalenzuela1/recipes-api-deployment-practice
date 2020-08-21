class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    if @recipes.empty?
      render :json => {
          :error => "ERROR: NO RECIPES TO SHOW. Add some recipes and come back"
      }
    else
      render :json => {
          :response => "HERE ARE YOUR RECIPES =>",
          :data => @recipes
      }
    end
  end
  def create
    puts "this is the create method"
    @new_category_recipe = Recipe.new(recipe_params)
    if Category.exists?(@new_category_recipe.category_id)
      if @new_category_recipe.save
        render :json => {
            :response => "Congrats!! You added a recipe!!",
            :data => @new_category_recipe
        }
      else
        render :json => {
            :response => "ERROR: Was not able to create a new recipe"
        }
      end
    else
      render :json => {
          :error => 'ERROR: Try another category'
      }
    end
  end
  def show
    @single_recipe=Recipe.exists?(params[:id])
    if @single_recipe
      render :json => {
          :response => "HERE IS ONE OF THE RECIPES ADDED =>",
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :error => "ERROR: Recipe was not found :("
      }
    end
  end
  def update
    if (@single_recipe_update=Recipe.find_by_id(params[:id])).present?
      @single_recipe_update.update(recipe_params)
      render :json => {
          :response => "Recipe was updated!",
          :data => @single_recipe_update
      }
    else
      render :json => {
          :error => "ERROR: Recipe unable to update"
      }
    end
  end
  def destroy
    if (@single_recipe_destroy=Recipe.find_by_id(params[:id])).present?
      @single_recipe_destroy.destroy
      render :json => {
          :response => "RECIPE HAS BEEN DELETED",
          :data => @single_recipe_destroy
      }
    else
      render :json => {
          :error => "ERROR: Recipe was unable to be deleted"
      }
    end
  end
  private
  def recipe_params
    params.permit(:category_id, :name, :ingredients, :directions, :notes, :tags)
  end

end
