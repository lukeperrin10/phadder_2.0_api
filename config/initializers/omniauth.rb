Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, 
  Rails.application.credentials.facebook[:google_key],
  Rails.application.credentials.facebook[:google_secret]

  if Rails.env.production?
    provider :facebook,
    Rails.application.credentials.facebook[:facebook_key],
    Rails.application.credentials.facebook[:facebook_secret]
  else
    provider :facebook, '216978619108390', 'c308f067e4163f82c87b93060adbd8b8'
  end
end