class User < ApplicationRecord
  devise :database_authenticatable
  
  validates :fullname, presence: true
  validates :email, presence: true
  validates :password, presence: true

  validates_uniqueness_of :email

  has_many :team_members, class_name: "User", foreign_key: "team_leader_id"
  has_many :initiatives
  
  belongs_to :team_leader, class_name: "User", required: false
end