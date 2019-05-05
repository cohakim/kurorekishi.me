class Timeline::NotifyCommand < Patterns::Command
  attr_reader :event, :credentials, :destroy_params

  def initialize(event:, credentials:, destroy_params:)
    @event          = event
    @credentials    = credentials
    @destroy_params = destroy_params
  end

  def call
    message =
      case event
      when :start_clean!    then destroy_params.start_message
      when :finish_clean!   then destroy_params.finish_message
      else raise(ArgumentError, 'Undefined event given')
      end
    twitter_client.post_status(message)
  end

  private

  def twitter_client
    MagicalTwitterClient.new(credentials)
  end
end
