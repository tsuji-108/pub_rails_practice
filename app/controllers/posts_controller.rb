class PostsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    # Thread などは名前が被りがちなので、命名を再考した方が良い。
    @chatThread = ChatThread.find(params[:chatThread_id])
    unless Current.user
      redirect_to new_session_path, alert: "ログインしてください。" and return
    end
    @post = @chatThread.posts.build(post_params)
    # id のみではなく Entity での関連付けをしたいため。
    # post_params から User 情報を引っ張ってくると、なりすましが可能なため、= Current.user で入れる。
    @post.user = Current.user

    if @post.save
      redirect_to "/boards/#{@board.id}/thread/#{@chatThread.id}"
    else
      @posts = @chatThread.posts.order(created_at: :asc)
      render "chat_threads/show", status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find(params[:chatThread_id])
    @post = @chatThread.posts.find(params[:id])
    # TODO: タイムスタンプの更新がこれで良いか確認する
    @post.archived_at = Time.now
    if @post.save
      redirect_to "/boards/#{@board.id}/thread/#{@chatThread.id}"
    else
      @posts = @chatThread.posts.order(created_at: :asc)
      render "chat_threads/show", status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @post.content = params[:content]
    @post.updated_at = Time.now

    if @post.save
      redirect_to "/boards/#{params[:board_id]}/thread/#{params[:chatThread_id]}"
    else
      render "chat_threads/show", status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
