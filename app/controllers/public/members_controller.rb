class Public::MembersController < ApplicationController
  before_action :set_member, only:[:bookmarks]
  before_action :ensure_guest_user, only: [:edit]
  # before_action :authenticate_member!
  # before_action :ensure_correct_member, only: [:show, :edit, :update]

  def show
    @member = Member.find(params[:id])
    @recipes = @member.recipes.page(params[:page]).per(4)
    @posts = @member.posts.page(params[:page]).per(6)
    @categories = Category.all
  end

  def myrecipe
    @recipes = Recipe.where(member_id: [current_member.id]).page(params[:page]).per(5)
    @categories = Category.all
  end
  
  def myalbum
    @posts = Post.where(member_id: [current_member.id]).page(params[:page]).per(5)
    @categories = Category.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def index
    @members = Member.all
  end

  def withdraw
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def bookmarks
    bookmarks = Bookmark.where(member_id: @member.id).pluck(:recipe_id)
    @bookmark_recipes = Recipe.find(bookmarks)
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_member
    @member = current_member
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end


  def ensure_guest_user
    @member = Member.find(params[:id])
    if @member.name == "guestuser"
      redirect_to member_path(current_member) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
