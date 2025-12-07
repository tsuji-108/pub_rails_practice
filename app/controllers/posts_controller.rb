class PostsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find(params[:chatThread_id])
    unless Current.user
      redirect_to new_session_path, alert: "ログインしてください。" and return
    end
    @post = @chatThread.posts.build(post_params)
    @post.user = Current.user

    if @post.save
      redirect_to board_chat_thread_path(board_id: @board.id, chatThread_id: @chatThread.id), notice: "投稿しました。"
    else
      @posts = @chatThread.posts.order(created_at: :asc)
      render "chat_threads/show", status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
