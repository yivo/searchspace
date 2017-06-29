Rails.application.routes.draw do
  scope format: false do
    root 'index#index', as: :index

    namespace :api do
      # https://stackoverflow.com/questions/5369654/why-do-routes-with-a-dot-in-a-parameter-fail-to-match

      get 'search/:phrase', to: 'search#index', as: :search, phrase: /[^\/]+/
      get 'details/:source/:url', to: 'details#show', url: /[^\/]+/
    end
  end
end
