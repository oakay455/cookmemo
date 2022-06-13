class Public::PostsController < ApplicationController
  before_action :authenticate_member!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @categories = Category.all
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
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to member_path(current_member)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :body)
  end
end
