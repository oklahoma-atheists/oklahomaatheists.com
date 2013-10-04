OklahomaatheistsCom::Application.routes.draw do
  root "home#index"

  resource :board
end
