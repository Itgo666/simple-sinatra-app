class UserApp < BaseApp

  get "/:id" do
    @user = User.find_by id: params[:id]
    halt_ok(@user)
  end

  get "/" do
    @list = User.all
    halt_ok(@list)
  end

  post "/" do
    @user = User.create username: @body[:username],
                        password: @body[:password],
                        email: @body[:email]
    if @user.valid?
      halt_ok @user
    else
      halt_err(:fail, @user.errors)
    end
  end
end
