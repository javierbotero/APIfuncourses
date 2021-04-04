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
    Rails.application.routes.url_helpers.rails_blob_path(main, only_path: true) if main.attached?
  end

  def images_url
    result = []
    if images.attached?
      images.each do |img|
        result.push(Rails.application.routes.url_helpers.rails_blob_path(img, only_path: true))
      end
    end
    result
  end

  # rubocop:disable Metrics/MethodLength
  def as_json(_options = {})
    super(
      include: [
        {
          teacher: {
            only: %i[
              id
              username
            ],
            methods: :url_avatar
          }
        },
        {
          favorites: {
            except: %i[
              created_at
              updated_at
            ]
          }
        },
        {
          subscriptions: {
            except: %i[
              created_at
              updated_at
            ]
          }
        },
        {
          confirmed_students: {
            only: %i[
              id
              username
            ],
            methods: :url_avatar
          }
        },
        {
          comments: {
            only: %i[
              body
              user_id
              course_id
            ],
            include: {
              user: {
                only: %i[
                  username
                  id
                ]
              }
            }
          }
        },
        {
          pendings: {
            except: %i[
              created_at
              updated_at
            ]
          }
        },
        {
          pending_students: {
            only: %i[
              id
              username
            ],
            methods: :url_avatar
          }
        }
      ],
      except: %i[
        link
        provider
      ],
      methods: %i[
        main_image_url
        images_url
      ]
    )
  end
  # rubocop:enable Metrics/MethodLength
end
