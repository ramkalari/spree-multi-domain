Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :stores
  end

  namespace :api do
    scope :module => :v1 do
      resources :stores
    end
  end
  
  
end


