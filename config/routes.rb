Shrinkwrap::Application.routes.draw do
  get '/:short_path' => 'short_urls#show'
  post '/' => 'short_urls#create'
end
