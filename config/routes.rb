Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  # CRUD 以外の操作には as をつけると分かりやすいかも。
  get "up" => "rails/health#show", as: :rails_health_check

  get "/boards", to: "boards#index"
  get "/boards/:board_id", to: "boards#show"

  get "/boards/:board_id/thread/:chatThread_id", to: "chat_threads#show"
  post "/boards/:board_id/thread", to: "chat_threads#create"
  put "/boards/:board_id/thread/:chatThread_id/update", to: "chat_threads#update"
  delete "/boards/:board_id/thread/:chatThread_id", to: "chat_threads#destroy"

  # TODO: Post に対する新規作成・更新・削除 URL は、/posts で良さそう。
  post "/boards/:board_id/thread/:chatThread_id/posts", to: "posts#create"
  put "/boards/:board_id/thread/:chatThread_id/posts/:id", to: "posts#update"
  delete "/boards/:board_id/thread/:chatThread_id/posts/:id", to: "posts#destroy"
end
