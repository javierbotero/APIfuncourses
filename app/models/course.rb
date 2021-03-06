class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :favorites, dependent: :destroy
  has_many :pendings, -> { where confirmed: false }, class_name: 'Subscription', dependent: :destroy
  has_many :subscriptions, -> { where confirmed: true }, dependent: :destroy
  has_many :comments, dependent: :destroy

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
