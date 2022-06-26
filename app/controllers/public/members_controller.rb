class Public::MembersController < ApplicationController
  before_action :set_member, only:[:bookmarks]
  before_action :ensure_guest_user, only: [:edit]
  before_action :move_to_login #ログインユーザーと管理者のみコメント権限を持たせ、未ログインの場合はログイン画面に遷移

  def show
    @member = Member.find(params[:id])
    @recipes = @member.recipes.order(created_at: :desc).page(params[:page]).per(8)
    @categories = Category.all
  end

  def myrecipe
    @recipes = Recipe.where(member_id: [current_member.id]).order(created_at: :desc).page(params[:page]).per(12)
    @categories = Category.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    # @member.profile_image.attach(params[:member][:profile_image])
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

  def move_to_login
    unless member_signed_in? || admin_signed_in?
      redirect_to new_member_session_path, notice: 'Please login'
    end
  end
end
