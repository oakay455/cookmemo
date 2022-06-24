class Public::PostsController < ApplicationController
  before_action :move_to_login #ログインユーザーと管理者のみ権限を持たせ、未ログインの場合はログイン画面に遷移

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = 'You have created post successfully.'
      redirect_to post_path(@post.id)
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @categories = Category.all
    @posts = Post.where(member_id: [current_member.id]).page(params[:page]).per(5)
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @categories = Category.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to member_myalbum_path(current_member)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :body)
  end

  def move_to_login
    unless member_signed_in? || admin_signed_in?
      redirect_to new_member_session_path, notice: 'Please login'
    end
  end
end