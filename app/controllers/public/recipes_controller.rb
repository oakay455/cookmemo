class Public::RecipesController < ApplicationController
 before_action :move_to_login, except:[:show, :index] #ログインユーザーと管理者のみコメント権限を持たせ、未ログインの場合はログイン画面に遷移

 def new
   @recipe = Recipe.new
   @categories = Category.all
 end

 def create
   @recipe = Recipe.new(recipe_params)
   @recipe.member_id = current_member.id
  if @recipe.save
   flash[:notice] = 'You have created recipe successfully.'
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
 if @recipe.update(recipe_params)
  flash[:notice] = 'You have updated recipe successfully.'
  redirect_to recipe_path(@recipe.id)
 else
  @categories = Category.all
  render :edit
 end
 end

 def bookmarks
  @bookmark_recipes = current_member.bookmark_recipes.includes(:member).order(created_at: :desc)
 end


 def recipe_search
  @recipes = Recipe.recipe_search(params[:keyword])
  @category = Category.all
 end
 
 
 def category_search
  @recipes = Recipe.where(category_id: params[:category_id])
 end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_image, :title, :body, :ingredient, :category_id)
  end

  def move_to_login
    unless member_signed_in? || admin_signed_in?
      redirect_to new_member_session_path, notice: 'Please login'
    end
  end
end
