class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  #カテゴリー検索
 def search
    @recipes = Recipe.where(category_id: params[:format]) #パラメーターで取得したジャンルIDをもとにgenre_idと一致する商品の取得
    @quantity = Recipe.where(category_id: params[:format]).count#検索してきた商品数をカウント
    @categories = Category.all
    @category = Category.find(params[:format])#ビューで検索したジャンル名を表示するため変数を用意
    render 'index'
 end

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
