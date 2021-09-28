require 'csv'

class UserImportService
  def initialize(file)
    @file = file
    @debug = true
  end

  def import
    users = []
    CSV.open(@file, headers: true).each { |row| users << User.new(row.to_hash) }
    User.import users
  end
end
