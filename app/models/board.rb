class Board < ApplicationRecord
  has_many :chatThreads, dependent: :destroy
end
