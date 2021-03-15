class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :favorites, dependent: :destroy
  has_many :pendings, -> { where confirmed: false }, class_name: 'Subscription', dependent: :destroy
  has_many :pending_students, through: :pendings, source: :user
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :confirmed_students, through: :subscriptions, source: :user
  has_many :comments, dependent: :destroy

  validates :link, :provider, :title, :content, :teacher_id, :dates, :price, presence: true
  validates :link, :provider, :title, :content, :dates, length: { in: 4..2000 }
  validates :link, :content, uniqueness: true

  def as_json(options = {})
    super(
      include: [
        {
          teacher: {
            only: [
              :id,
              :username,
            ],
          }
        },
        {
          favorites: {
            except: [
              :created_at,
              :updated_at
            ]
          }
        },
        {
          subscriptions: {
            except: [
              :created_at,
              :updated_at
            ]
          }
        },
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
          comments: {
            include: {
              user: {
                only: [
                  :username,
                  :id
                ],
              },
            },
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
        }
      ],
      except: [
        :link,
        :provider,
      ]
    )
  end
end
