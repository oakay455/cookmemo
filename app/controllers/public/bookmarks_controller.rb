class Public::BookmarksController < ApplicationController
  before_action :authenticate_member!, only: [:create, :destroy]   # ログイン中のユーザーのみに許可（未ログイン→ログイン画面へ）
  before_action :recipe_params, only: [:create, :destroy]

  # お気に入り登録
  def create
    Bookmark.create(member_id: current_member.id, recipe_id: @recipe.id)
  end

  # お気に入り解除
  def destroy
    bookmark = Bookmark.find_by(member_id: current_member.id, recipe_id: @recipe.id)
    bookmark.destroy
  end

  private

  def recipe_params
    @recipe = Recipe.find(params[:recipe_id])
  end
end
