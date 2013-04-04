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

  # Command: log +message+ to Pivotal Tracker if +condition+ is true.
  #
  # The +message+ to log can the result of block evaluation:
  #
  #   log_if(condition) do
  #     "evaluate the message to log here with implicit PT:999999 story id"
  #   end
  #
  # Or the +message+ to log can be passed as an arguent:
  #
  #   log_if(condition,message)
  #
  # An explicit story ID can be provided in both block and args form:
  #
  #   log_if(condition,story_id) do
  #     "evaluate the message to log here"
  #   end
  #
  #   log_if(condition,message,story_id)
  #
  # If +story_id+ is provided, logs to that story, else logs to a story ID
  # referenced in the message itself (as #999 or PT:999).
  #
  # Returns true if log was successful, else false.
  # Supresses any StandardErrors that may occur during logging.
  #
  def self.log_if(condition,*args)
    return false unless condition
    message = block_given? ? yield : args.shift
    log(message,*args)
  end

end