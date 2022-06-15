class Public::RecipeFavoritesController < ApplicationController
  before_action :authenticate_member!, only: [:create, :destroy]
  before_action :recipe_params, only: [:create, :destroy]

  def create
    RecipeFavorite.create(member_id: current_member.id, recipe_id: @recipe.id)
  end

  def destroy
    recipe_favorite = RecipeFavorite.find_by(member_id: current_member.id, recipe_id: @recipe.id)
    recipe_favorite.destroy
  end

   private
  def recipe_params
    @recipe = Recipe.find(params[:recipe_id])
  end
end
