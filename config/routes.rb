Rails.application.routes.draw do
  resources :posts
  resources :users
  resources :comments
  post "login", to: "authentication#login"
  post 'authenticate', to: 'authentication#authenticate'
  post 'signup', to: 'users#signup'
  get 'user/my_posts', to: 'users#my_posts'
  post 'post/comment', to: 'posts#comment'
  get 'post/all_comments', to: 'posts#all_comments'
  post 'comments/update', to: 'comments#update'
  post 'comments/delete', to: 'comments#delete'
  post 'posts/update_tags', to: 'posts#update_tags'
end
