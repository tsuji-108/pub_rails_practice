class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:board_id])
    @chatThread = ChatThread.find_by(board_id: params[:board_id])
  end
end
