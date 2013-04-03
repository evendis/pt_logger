module PtLogger

  # Pivotal Tracker credentials
  mattr_accessor :api_key
  mattr_accessor :project_id

  # Default way to setup. Yields a block that gives access to all the config variables.
  def self.setup
    yield self
  end

end