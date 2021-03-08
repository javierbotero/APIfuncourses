class User < ApplicationRecord
  has_secure_password
  has_many :requested_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :accepted_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :pending_requested_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :pending_accepted_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :requests, through: :accepted_friendships, source: :sender
  has_many :pendings, through: :requested_friendships, source: :receiver
  has_many :favorites, dependent: :destroy
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :pending_subscriptions, -> { where confirmed: false }, class_name: 'Subscription', foreign_key: 'user_id'
  has_many :courses, foreign_key: 'teacher_id'
  has_many :comments

  validates :username, :password, :email, presence: true
  validates :username, :password, :email, length: { in: 4..100 }
  validates :username, :email, uniqueness: true

  def friends
    friends = requests + pendings
    friends.map do |friend|
      {
        id: friend.id,
        username: friend.username,
        favorites: friend.favorites,
        subscriptions: friend.subscribed_courses.map{ |c| c.id },
        courses: friend.courses.map{ |c| c.id },
        comments: friend.comments
      }
    end
  end

  def as_json(options = {})
    super(
      only: [
        :username,
        :id,
      ],
      include: [
        :subscriptions,
        :pending_subscriptions,
        :subscriptions,
        :comments,
        :favorites,
        :courses,
      ]
    )
  end
end
