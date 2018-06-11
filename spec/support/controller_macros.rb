module ControllerMacros
  def login_user
    before(:each) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create!(email: 'user@email.com', password: '123456789')
      sign_in user
    end
  end
end
