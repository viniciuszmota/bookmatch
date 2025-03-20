class Message < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :content, presence: true
  after_create_commit :broadcast_message
  def broadcast_message
    broadcast_append_to "match_#{match.id}_messages",
                        partial: "messages/message",
                        target: "messages",
                        locals: { message: self }
  end

  scope :unread_by, ->(user) { where(read: nil).where.not(user: user) }
end