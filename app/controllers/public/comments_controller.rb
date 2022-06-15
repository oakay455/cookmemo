class Public::CommentsController < ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = current_member.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    if @comment.save!
      flash.now[:notice] = 'コメントを投稿しました'
      render :comment  #render先にjsファイルを指定
    else
      render :error
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    #renderしたときに@postのデータがないので@postを定義
    @recipe = Recipe.find(params[:recipe_id])
    render :comment  #render先にjsファイルを指定
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
