module CredentialsHelper

  # Command: sets test PT credentials
  def set_test_credentials
    PtLogger.setup do |config|
      config.api_key = test_api_key
      config.project_id = test_project_id
    end
  end

  # Returns true if real PT credentials have been configured
  def real_credentials_available?
    if real_api_key
      STDERR.puts %{
NOTE: real PT credentials are configured so if the integration tests are missing request cassettes,
live queries will be performed to record the actual interaction.
      }
      true
    else
      STDERR.puts %{
NOTE: real PT credentials are not configured so if the integration tests are missing request cassettes,
they will fail. Set real PT credentials with environment variables:

  export TEST_PTLOGGER_API_KEY=your_api_key

      }
      false
    end
  end

  # Returns the API Key to use for tests
  def test_api_key
    real_api_key || 'fakeapikey'
  end
  def real_api_key
    ENV['TEST_PTLOGGER_API_KEY']
  end

  # Returns the project ID to use for tests
  def test_project_id
    '703897'
  end

  # Returns the story ID to use for tests
  def test_story_id
    '47387051'
  end

end

RSpec.configure do |conf|
  conf.extend CredentialsHelper
  conf.include CredentialsHelper
end