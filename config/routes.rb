# Match IDs with dots in them
id_pattern = /[^\/]+/

ResqueWeb::Application.routes.draw do

  resource  :overview,  :only => [:show], :controller => :overview
  resources :working,   :only => [:index]
  resources :queues,    :only => [:index,:show,:destroy], :constraints => {:id => id_pattern}
  resources :workers,   :only => [:index,:show], :constraints => {:id => id_pattern}
  resources :failures,  :only => [:show,:index,:destroy] do
    member do
      put 'retry'
    end
    collection do
      put 'retry_all'
      delete 'destroy_all'
    end
  end

  get '/stats' => "stats#index"
  get '/stats/:action',     :controller => :stats
  get '/stats/:action/:id', :controller => :stats, :constraints => {:id => id_pattern}

  root :to => 'overview#show'

end
