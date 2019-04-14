class RootApp < BaseApp

  get "/" do
    halt_ok("root")
  end
end
