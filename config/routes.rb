# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :project, only: [] do
  resources :versions, only: [] do
    member do
      get '/create_subversion', to: "subversions#create"
    end
  end

end