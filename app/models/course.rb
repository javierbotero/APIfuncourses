class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :favorites, dependent: :destroy
  has_many :pendings, -> { where confirmed: false }, class_name: 'Subscription', dependent: :destroy
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :link, :provider, :title, :content, :teacher_id, :dates, :price, presence: true
  validates :link, :provider, :title, :content, :dates, length: { in: 4..2000 }
  validates :link, :title, :content, uniqueness: true

  def as_json(options = {})
    super(
      include: [
        {
          teacher: {
            only: [
              :username,
            ],
          }
        },
        :favorites,
        :subscriptions,
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
        :pendings,
      ],
      except: :link,
    )
  end
end
