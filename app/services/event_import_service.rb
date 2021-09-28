require 'csv'

class EventImportService
  def initialize(file)
    @file = file
  end

  def import
    events = []
    invitations = []

    CSV.open( @file, headers: true ).each do |row|
      row = row.to_h
      event = Event.new(row.except("users#rsvp"))
      event.completed = event.is_completed?
      users_rsvp = {}
      if row['users#rsvp'].present?
        row['users#rsvp'].split(';').each {|u| users_rsvp[u.split('#').first] = u.split('#').last } 
        event_users = User.where(username: users_rsvp.keys)
        event_users.each {|eu| invitations << event.invitations.build(user_id: eu.id, rsvp: Invitation.rsvps[users_rsvp[eu.username]] )} 
      end
      events << event
    end

    invitations.group_by(&:user_id).each do | _ , invites|
      accepted_invites = invites.reject{|invite| invite.no?}
      (0...accepted_invites.length).each do |index|
        unless index == accepted_invites.length - 1
          ((index + 1)...accepted_invites.length).each do |i|
            if accepted_invites[index].event.period.overlaps?(accepted_invites[i].event.period)
              accepted_invites[index].rsvp = 'no'
              break
            end
          end
        end
      end
    end

    Event.import events, recursive: true
  end
end
