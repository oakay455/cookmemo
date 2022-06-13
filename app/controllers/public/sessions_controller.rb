# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
   member_path(current_member)
  end

  def after_sign_out_path_for(resource)
   root_path
  end


  protected
#会員情報を確認
  def member_state
    #memberテーブルからemail情報をもとにmemberのデータを引き出す
    @member = Member.find_by(email: params[:member][:email])
    #データが引き出せない場合は、処理を終了させる。
    return if !@member
    #パスワードがあってるいる、かつ、退会ステータスがtrueの場合処理を実行する
    if @member.valid_password?(params[:member][:password]) && @member.is_deleted == true
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_member_registration_path
    end
  end
end
