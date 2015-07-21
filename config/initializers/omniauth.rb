# https://github.com/zquestz/omniauth-google-oauth2
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end

# Catch failure errors in dev. (E.g. user cancels authorization on Google page.)
# http://stackoverflow.com/a/11028187/1093087
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
