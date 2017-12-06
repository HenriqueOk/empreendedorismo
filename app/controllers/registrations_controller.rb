class RegistrationsController < Devise::RegistrationsController
  layout 'home'
    
  private

  def after_sign_in_path_for(resource)
    interests_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
    
end
