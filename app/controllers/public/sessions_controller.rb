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
#退会しているか判断
  def member_state
    #入力されたemailからアカウントを取得
    @member = Member.find_by(email: params[:member][:email])
    #アカウントを取得できなかった場合、このメソッドを終了させる。
    return if !@member
    #取得したアカウントのパスワードが一致している、かつ、退会ステータスがtrueかどうかを
    if @member.valid_password?(params[:member][:password]) && @member.is_deleted == true
      flash[:notice] = "退会済みです。新規会員登録をしてご利用ください。"
      redirect_to new_member_registration_path
    end
  end
end
