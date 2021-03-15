class User < ApplicationRecord
  has_secure_password
  has_many :requested_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :accepted_friendships, -> { where confirmed: true }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :pending_requested_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :pending_to_accept_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :friendship_requests, through: :pending_to_accept_friendships, source: :sender
  has_many :requests, through: :accepted_friendships, source: :sender
  has_many :pendings, through: :requested_friendships, source: :receiver
  has_many :favorites, dependent: :destroy
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :courses_as_student, through: :subscriptions, source: :course
  has_many :pending_subscriptions, -> { where confirmed: false }, class_name: 'Subscription', foreign_key: 'user_id'
  has_many :pending_courses_as_student, through: :pending_subscriptions, source: :course
  has_many :courses, foreign_key: 'teacher_id'
  has_many :comments

  validates :username, :password, :email, presence: true
  validates :username, :password, :email, length: { in: 4..100 }
  validates :username, :email, uniqueness: true

  def as_json(options = {})
    super(
      only: [
        :username,
        :id,
      ],
      include: [
        {
          courses_as_student: {
            except: [
              :created_at,
              :updated_at,
              :link,
            ],
            include: :favorites
          }
        },
        {
          pending_courses_as_student: {
            only: [
              :id,
              :title,
              :content,
              :teacher_id,
              :dates,
            ],
            include: :favorites
          }
        },
        {
          comments: {
            only: [
              :body,
              :course_id,
            ]
          }
        },
        {
          favorites: {
            only: :course_id
          }
        },
        {
          pending_to_accept_friendships: {
            except: [
              :created_at,
              :updated_at,
            ]
          }
        },
        {
          friendship_requests: {
            only: [
              :id,
              :username,
              :email,
            ]
          }
        },
        {
          requests: {
            except: [
              :created_at,
              :updated_at,
              :password_digest,
              :password_confirmation,
            ],
            include: [
              {
                courses_as_student: {
                  only: [
                    :id,
                    :title,
                    :content,
                  ],
                  include: :favorites
                }
              },
              {
                courses: {
                  only: [
                    :id,
                    :title,
                    :content,
                  ],
                  include: :favorites
                }
              },
              {
                comments: {
                  only: [
                    :body,
                    :course_id,
                  ]
                }
              }
            ]
          }
        },
        {
          pendings: {
            except: [
              :created_at,
              :updated_at,
              :password_digest,
              :password_confirmation,
            ],
            include: [
              {
                courses_as_student: {
                  only: [
                    :id,
                    :title,
                    :content,
                  ],
                  include: :favorites
                }
              },
              {
                courses: {
                  only: [
                    :id,
                    :title,
                    :content,
                  ],
                  include: :favorites
                }
              },
              {
                comments: {
                  only: [
                    :body,
                    :course_id,
                  ]
                }
              }
            ]
          }
        },
        {
          courses: {
            include: [
              {
                confirmed_students: {
                  only: [
                    :id,
                    :username,
                    :email,
                  ]
                }
              },
              {
                subscriptions: {
                  except: [
                    :created_at,
                    :updated_at,
                  ]
                }
              },
              {
                pendings: {
                  except: [
                    :created_at,
                    :updated_at
                  ]
                }
              },
              {
                pending_students: {
                  only: [
                    :id,
                    :username,
                    :email,
                  ]
                }
              },
              :favorites
            ]
          }
        }
      ]
    )
  end
end
