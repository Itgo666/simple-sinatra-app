class InfoApp < BaseApp

  get "/hello" do
    halt_ok("info_hello")
  end

end
