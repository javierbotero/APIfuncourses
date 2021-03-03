class User < ApplicationRecord
  has_many :requested_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :accepted_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :pending_requested_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :pending_accepted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :requests, through: :pending_accepted_friendships, source: :sender
  has_many :pendings, through: :pending_requested_friendships, source: :receiver

#   def friends
#     requester_friends_true = requester_friends.where(confirmed: true)
#     accepted_friends_true = accepted_friends.where(confirmed: true)
#     requester_friends + accepted_friends
#   end
end
