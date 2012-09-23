Shrinkwrap::Application.routes.draw do
  resources :short_urls, :only => :create, :path => ""
end
