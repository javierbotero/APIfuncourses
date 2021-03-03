class User < ApplicationRecord
  has_many :requested_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :accepted_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :pending_requested_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :pending_accepted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :requests, through: :accepted_friendships, source: :sender
  has_many :pendings, through: :requested_friendships, source: :receiver
  has_many :favorites
  has_many :subscriptions
  has_many :courses, foreign_key: 'teacher_id'
  has_many :comments

  def friends
    requests + pendings
  end
end
