Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, except: [:destroy] # Exclure la route par défaut pour destroy
  # Redéfinir la route destroy avec un nom personnalisé
  delete '/recipes/:id/delete', to: 'recipes#destroy', as: 'delete_recipe'
  root "recipes#index"
end
