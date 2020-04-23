module ApplicationHelper
  def sign_in_out
    if user_signed_in?
      my_link_to('Sign Out', destroy_user_session_path, 'delete') 
    else
      my_link_to('Sign In', new_user_session_path)
    end
  end

  def my_link_to(text, href, method='get')
    "<a href='#{href}' data-method='#{method}'>#{text}</a>".html_safe
  end
end
