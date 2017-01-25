class Member < ApplicationRecord
  has_many :channels, class_name: 'ChannelMember'
  has_many :posts
  has_many :stocks
  has_many :stocked_posts, through: :stocks, source: :post
  has_many :templates

  belongs_to :team
  belongs_to :user

  validates :team, presence: true
  validates :user, presence: true, uniqueness: { scope: :team }
  validates :role, presence: true
  validates :screen_name,
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    length: { in: 3..64 },
    presence: true,
    uniqueness: { scope: :team }

  enum role: { member: 0, owner: 10 }
end
