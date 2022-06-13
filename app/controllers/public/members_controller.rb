class Public::MembersController < ApplicationController
  # before_action :authenticate_member!
  # before_action :ensure_correct_member, only: [:show, :edit, :update]

  def show
    @member = Member.find(params[:id])
    @recipes = @member.recipes
    @posts = @member.posts
    # @posts = Post.all.order(created_at: :desc)
    @categories = Category.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path(@member.id)
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
end
