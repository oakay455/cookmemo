class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @member = Member.find(params[:id])
  end

  def index
    @members = Member.page(params[:page])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "#{@member.name}さんの会員情報を更新しました"
       redirect_to admin_member_path(@member.id)
    else
       render :edit
    end
  end

  def recipe_index
    @member = Member.find(params[:member_id])
    @recipes = @member.recipes.order("created_at DESC").page(params[:page]).per(10)
  end

  private
 def member_params
    params.require(:member).permit(:name, :email, :is_deleted)
 end

end
