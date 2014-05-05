OklahomaatheistsCom::Application.routes.draw do
  root "home#index"

  resource :board
  resource :contact

  get "/redirect" => "domains#show"
end
