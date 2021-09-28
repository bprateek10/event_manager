class Event < ApplicationRecord
  # Associations
  has_many :invitations
  has_many :users, through: :invitations

  # Scopes
  scope :all_day_event, -> { where(allday: true) }

  def is_completed?
    (allday && endtime.to_date < Date.today) || (!allday && endtime < DateTime.now)
  end

  def period
    if allday
      starttime.beginning_of_day..starttime.end_of_day
    else
      starttime...endtime
    end
  end
end
