class Public::RecipesController < ApplicationController
 # before_action :authenticate_member!

 def new
   @recipe = Recipe.new
   @categories = Category.all
 end

 def create
   @recipe = Recipe.new(recipe_params)
   @recipe.member_id = current_member.id
  if @recipe.save
      redirect_to recipe_path(@recipe.id)
  else
    @categories = Category.all
      render "new"
  end
 end

 def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
 end

 def index
  #投稿が新しい順に並べて表示
  @recipes = Recipe.all.order(created_at: :desc)
  @categories = Category.all
 end

 def show
  @recipe = Recipe.find(params[:id])
  @categories = Category.all
  @comment = Comment.new
 end

 def edit
 @recipe = Recipe.find(params[:id])
 @categories = Category.all
 end

 def update
 @recipe = Recipe.find(params[:id])
 @recipe.update(recipe_params)
 redirect_to recipe_path(@recipe.id)
 end

 def bookmarks
  @bookmark_recipes = current_member.bookmark_recipes.includes(:member).order(created_at: :desc)
 end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_image, :title, :body, :ingredient, :category_id)
  end
end
