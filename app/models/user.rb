class User < ApplicationRecord
  # Associations
  has_many :invitations
  has_many :events, through: :invitations
end
