module PtLogger

  def self.log(message,story_id=nil)
    if pt = PtLogger::Logger.new
      pt.append_story_note(message,story_id)
    end
  end

end