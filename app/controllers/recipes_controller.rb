class RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    if session[:user_id]
      render json: recipes, status: :created
    else
      render json: { errors: ["User not logged in"] }, status: :unauthorized
    end
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.user_id = session[:user_id]
    if session[:user_id]
      if recipe.valid?
        recipe.save
        render json: recipe, status: :created
      else
        render json: { errors: ["Recipe not valid"]}, status: :unprocessable_entity
      end
    else
      render json: { errors: ["You are not logged in."]}, status: :unauthorized
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user_id)
  end
end