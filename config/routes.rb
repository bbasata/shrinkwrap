Shrinkwrap::Application.routes.draw do
  resources :short_urls, :only => [ :show, :create ], :path => ""
end
