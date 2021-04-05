# rubocop:disable Metrics/ClassLength
class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize: '200x200'
  end
  has_many_attached :images
  has_many :requested_friendships, lambda {
                                     where confirmed: true
                                   }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :accepted_friendships, lambda {
                                    where confirmed: true
                                  }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :pending_requested_friendships, lambda {
                                             where confirmed: false
                                           }, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :pending_to_accept_friendships, lambda {
                                             where confirmed: false
                                           }, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy
  has_many :friendship_requests, through: :pending_to_accept_friendships, source: :sender
  has_many :requests, through: :accepted_friendships, source: :sender
  has_many :pendings, through: :requested_friendships, source: :receiver
  has_many :favorites, dependent: :destroy
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :courses_as_student, through: :subscriptions, source: :course
  has_many :pending_subscriptions, -> { where confirmed: false }, class_name: 'Subscription', foreign_key: 'user_id'
  has_many :pending_courses_as_student, through: :pending_subscriptions, source: :course
  has_many :courses, foreign_key: 'teacher_id'
  has_many :comments, dependent: :destroy

  validates :username, :password, :email, presence: true
  validates :username, :password, :email, length: { in: 4..100 }
  validates :username, :email, uniqueness: true
  validates :email,
    format: {
      with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i,
      message: 'email should be valid'
    }

  def url_avatar
    Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) if avatar.attached?
  end

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    super(
      only: %i[
        username
        id
        status
      ],
      methods: :url_avatar,
      include: [
        {
          courses_as_student: {
            only: %i[
              id
              link
              provider
            ]
          }
        },
        {
          pending_courses_as_student: {
            only: %i[
              id
              title
            ]
          }
        },
        {
          comments: {
            only: %i[
              body
              course_id
            ],
            include: [
              course: {
                only: :title
              }
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
            except: %i[
              created_at
              updated_at
            ]
          }
        },
        {
          pending_requested_friendships: {
            except: %i[
              created_at
              updated_at
            ]
          }
        },
        {
          friendship_requests: {
            only: %i[
              id
              username
              avatar
            ]
          }
        },
        {
          requests: {
            except: %i[
              created_at
              updated_at
              password_digest
              password_confirmation
            ],
            include: [
              {
                courses_as_student: {
                  only: :id
                }
              },
              {
                courses: {
                  only: :id
                }
              },
              {
                comments: {
                  only: %i[
                    body
                    course_id
                    user_id
                  ],
                  include: [
                    {
                      course: {
                        only: :title
                      }
                    }
                  ]
                }
              }
            ]
          }
        },
        {
          pendings: {
            except: %i[
              created_at
              updated_at
              password_digest
              password_confirmation
            ],
            include: [
              {
                courses_as_student: {
                  only: :id
                }
              },
              {
                courses: {
                  only: :id
                }
              },
              {
                comments: {
                  include: [
                    {
                      user: {
                        only: %i[
                          username
                          id
                        ]
                      }
                    }
                  ],
                  only: %i[
                    body
                    course_id
                    user_id
                  ]
                }
              }
            ]
          }
        },
        {
          courses: {
            only: %i[
              id
              link
              provider
            ]
          }
        }
      ]
    )
  end
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ClassLength
