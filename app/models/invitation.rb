class Invitation < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :event

  # Enums
  enum rsvp: %i[yes no maybe], _default: 'yes'
end
