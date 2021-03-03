class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :pendings, -> { where confirmed: false }, class_name: 'Subscription'
  has_many :subscriptions, -> { where confirmed: true }
  has_many :users, through: :subscriptions
  has_many :comments
end
