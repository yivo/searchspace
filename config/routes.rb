Rails.application.routes.draw do
  scope format: false do
    root 'index#index', as: :index

    namespace :api do
      get 'search/:phrase', to: 'search#index', as: :search
    end
  end
end
