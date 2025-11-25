class BoardsController < ApplicationController
  # def index
  #   @boards = Board.all
  # end

  def index
    @board = Board.find(1)
    @chatThread = ChatThread.find_by(board_id: 1)
  end
end
