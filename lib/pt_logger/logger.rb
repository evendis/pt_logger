class PtLogger::Logger

  def initialize
    PivotalTracker::Client.use_ssl = true
    PivotalTracker::Client.token = api_key
  end

  def env
    Rails.env
  rescue
  end

  def api_key
    PtLogger.api_key
  end

  def project_id
    PtLogger.project_id
  end

  def project
    @project ||= if project_id
      PivotalTracker::Project.find(project_id)
    end
  end

  # Command: appends +message+ to PT story +story_id+.
  # Does nothing if +story_id+ not defined
  #
  # If story_id is :infer or nil: looks for a story ID in the message (either #999999999 or PT:999999999 )
  #
  def append_story_note(message,story_id=nil)
    if (story_id ||= :infer) == :infer
      story_id = extract_story_id_from(message)
    end
    return false unless story_id
    send_story_note!("[#{prepend_text}] #{message}",story_id)
    true
  end

  def extract_story_id_from(message)
    if matches = /(PT:|#)(\d+)(\s|$)/i.match(message)
      if matches.size > 3
        matches[2].to_i
      end
    end
  end

  def prepend_text
    ['PtLogger',env].compact.join('::')
  end

  # sends the prepared +message+ as a note on +story_id+
  def send_story_note!(message,story_id)
    return unless project
    if story = project.stories.find(story_id)
      story.notes.create(:text => message, :noted_at => Time.now)  # add a new note
    end
  end

end
