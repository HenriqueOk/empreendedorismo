class SessionsController < Devise::SessionsController
  layout 'home'

  def after_sign_in_path_for(resource)
    interests_path
  end
end