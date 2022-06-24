class Public::CommentsController < ApplicationController
  before_action :move_to_login #ログインユーザーと管理者のみコメント権限を持たせ、未ログインの場合はログイン画面に遷移

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = current_member.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    if @comment.save!
      flash.now[:notice] = 'You have created comment successfully.'
      render :comment  #render先にjsファイルを指定
    else
      render :error
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id]).destroy
    flash.now[:alert] = 'comment deleted'
    #renderしたときに@postのデータがないので@postを定義
    @recipe = Recipe.find(params[:recipe_id])
    render :comment  #render先にjsファイルを指定
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def move_to_login
    unless member_signed_in? || admin_signed_in?
      redirect_to new_member_session_path, notice: 'Please login'
    end
  end

end
