module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present? #メソッドを使ってる
  end

  # def current_admin?
  #   if current_user.admin == true 
  #     true
  #   else 
  #     false #メソッドを使ってる
  #   end
  #end

end
