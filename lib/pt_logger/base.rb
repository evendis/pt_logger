module PtLogger

  # Command: log +message+ to Pivotal Tracker.
  # If +story_id+ is provided, logs to that story, else logs to a story ID
  # referenced in the message itself (as #999 or PT:999).
  #
  # Returns true if log was successful, else false.
  # Supresses any StandardErrors that may occur during logging.
  #
  def self.log(message,story_id=nil)
    if pt = PtLogger::Logger.new
      pt.append_story_note(message,story_id)
    else
      false
    end
  rescue
    false
  end

end