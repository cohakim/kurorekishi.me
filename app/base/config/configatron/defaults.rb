# bugsnag
configatron.bugsnag.api_key = Rails.application.credentials.bugsnag[:api_key]

# service credentials
configatron.twitter.consumer_key    = Rails.application.credentials.twitter[:consumer_key]
configatron.twitter.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]

# AWS
configatron.aws.region            = 'ap-northeast-1'
configatron.aws.s3.bucket_name    = 'kurorekishi-me'
