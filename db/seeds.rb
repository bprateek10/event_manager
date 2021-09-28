class SeedImporter
  def initialize(file_base_name)
    @file_base_name = file_base_name
    @service_class = nil
  end

  def run
    init_service_class
    @service_class.new(file).import
  end

  def file
    File.join(seed_dir, "#{@file_base_name}.csv")
  end

  def service_class
    (@file_base_name.singularize + '_import_service').classify
  end

  def init_service_class
    @service_class = Object.const_get(service_class)
  end

  def seed_dir
    File.dirname(__FILE__) + '/seed_data'
  end
end

SeedImporter.new('users').run
SeedImporter.new('events').run
