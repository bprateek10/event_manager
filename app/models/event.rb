class Event < ApplicationRecord
  # Associations
  has_many :invitations
  has_many :users, through: :invitations

  def is_completed?
    (allday && endtime.to_date < Date.today) || (!allday && endtime < DateTime.now)
  end

  def period
    if allday
      starttime...((starttime.to_date+1).to_datetime)
    else
      starttime...endtime
    end
  end
end
