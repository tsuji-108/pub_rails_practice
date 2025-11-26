class ChatThreadsController < ApplicationController
  def show
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find(params[:chatThread_id])
  end
end
