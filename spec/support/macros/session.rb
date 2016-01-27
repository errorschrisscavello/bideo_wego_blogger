module Macros
  module Session
    def sign_in(user)
      page.find('#username_or_email').set(user.email)
      page.find('#password').set(user.password)
      find('.btn-default[type="submit"]').click
    end


    def sign_out
      visit logout_path
    end
  end
end

