Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check

  get "/boards", to: "boards#index"
  get "/boards/:board_id", to: "boards#show"

  get "/boards/:board_id/thread/:chatThread_id", to: "chat_threads#show", as: :board_chat_thread
  post "/boards/:board_id/thread/:chatThread_id/posts", to: "posts#create", as: :chat_thread_posts
end
