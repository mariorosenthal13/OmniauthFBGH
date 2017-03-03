Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
            ENV.fetch("GITHUB_ID"),
            ENV.fetch("GITHUB_SECRET"),
            scope: 'user:email'
  provider :facebook,
            ENV.fetch('FACEBOOK_KEY'),
            ENV.fetch('FACEBOOK_SECRET'),
            scope: 'email, public_profile'
end
