class Post < ApplicationRecord
  belongs_to :user
  belongs_to :chat_thread

  has_one_attached :image

  validate :image_content_type, if: -> { image.attached? }
  validate :image_size, if: -> { image.attached? }

  private

  def image_content_type
    return if image.blob.content_type.in?(%w[image/png image/jpeg image/jpg image/gif image/webp])

    errors.add(:image, "対応していない画像形式です")
  end

  def image_size
    return if image.blob.byte_size <= 5.megabytes

    errors.add(:image, "ファイルサイズは5MB以下にしてください")
  end
end
