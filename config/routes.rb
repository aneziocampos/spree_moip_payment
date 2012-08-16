Spree::Core::Engine.routes.draw do
  match '/moip_callback' => 'moip_callbacks#nasp', :via => [:post]
end
