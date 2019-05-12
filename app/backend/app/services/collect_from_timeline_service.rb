class CollectFromTimelineService
  class << self
    def collect!(credentials, collect_params)
      twitter_client = MagicalTwitterClient.new(credentials)
      twitter_client.retrieve_timeline do |tweet|
        collect_policy = CollectPolicy.new(
          collect_parameter: collect_params,
          tweet: NormalizedStatus.new(tweet),
        )
        yield tweet if collect_policy.can_destroy?
      end
    end
  end
end
