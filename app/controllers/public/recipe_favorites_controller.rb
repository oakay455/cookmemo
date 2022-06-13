class Public::RecipeFavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_member.recipe_favorites.new(recipe_id: @recipe.id)
    favorite.save
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    favorite = current_member.recipe_favorites.find_by(recipe_id: @recipe.id)
    favorite.destroy
    redirect_to recipe_path(@recipe)
  end
end
