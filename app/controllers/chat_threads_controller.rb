class ChatThreadsController < ApplicationController
  def show
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find(params[:chatThread_id])
    # NOTE: .find は 1 件のみ取得する。where は複数件取得する。
    @posts = @chatThread.posts.order(created_at: :asc)
    @post = @chatThread.posts.build
    @currentUser = Current.user
  end

  def create
    @board = Board.find(params[:board_id])
    unless Current.user
      redirect_to new_session_path, alert: "ログインしてください。" and return
    end
    @chatThread = ChatThread.new(
      user_id: Current.user.id,
      board_id: @board.id,
      title: params[:title],
      description: params[:description],
    )

    if @chatThread.save
      redirect_to "/boards/#{@board.id}/thread/#{@chatThread.id}"
    else
      render "boards/show", status: :unprocessable_entity
    end
  end

  def update
    @chatThread = ChatThread.find(params[:chatThread_id])
    @chatThread.title = params[:title]
    @chatThread.description = params[:description]

    if @chatThread.save
      redirect_to "/boards/#{params[:board_id]}/thread/#{params[:chatThread_id]}"
    else
      render "boards/show", status: :unprocessable_entity
    end
  end

  def destroy
    # TODO:
    render "boards/show", status: :unprocessable_entity
  end
end
