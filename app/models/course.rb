class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_one_attached :main
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :pendings, -> { where confirmed: false }, class_name: 'Subscription', dependent: :destroy
  has_many :pending_students, through: :pendings, source: :user
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :confirmed_students, through: :subscriptions, source: :user
  has_many :comments, dependent: :destroy

  validates :link, :provider, :title, :content, :teacher_id, :dates, :price, presence: true
  validates :link, :provider, :title, :content, :dates, length: { in: 4..2000 }
  validates :link, :content, uniqueness: true

  def main_image_url
    Rails.application.routes.url_helpers.rails_blob_path(self.main, only_path: true) if self.main.attached?
  end

  def images_url
    result = []
    if self.images.attached?
      self.images.each do |img|
        result.push(Rails.application.routes.url_helpers.rails_blob_path(img, only_path: true))
      end
    end
    result
  end

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
            only: [
              :body,
              :user_id,
              :course_id,
            ],
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
          pendings: {
            except: [
              :created_at,
              :updated_at,
            ]
          }
        },
        {
          pending_students: {
            only: [
              :id,
              :username,
            ]
          }
        }
      ],
      except: [
        :link,
        :provider,
      ],
      methods: [
        :main_image_url,
        :images_url,
      ]
    )
  end
end
