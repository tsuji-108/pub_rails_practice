class ChatThreadsController < ApplicationController
  def show
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find(params[:chatThread_id])
    # NOTE: .find は 1 件のみ取得する。where は複数件取得する。
    @posts = @chatThread.posts.order(created_at: :asc)
    @post = @chatThread.posts.build
    @currentUser = Current.user
  end
end
