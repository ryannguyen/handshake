Rails.application.routes.draw do
  root "chirps#index"
  
  resources :chirps do
    member do 
      get :upvote
      get :downvote
    end
  end
end
