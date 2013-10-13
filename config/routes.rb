OklahomaatheistsCom::Application.routes.draw do
  root "home#index"

  resource :board
  resource :contact
end
