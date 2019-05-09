Aws.config[:region] = configatron.aws.region
if Rails.env.development?
  Aws.config[:credentials] = Aws::Credentials.new(
    configatron.aws.access_key_id,
    configatron.aws.secret_access_key
  )
end
