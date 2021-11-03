Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.production?
    provider :facebook,
   Rails.application.credentials.facebook[:APP_ID],
   Rails.application.credentials.facebook[:APP_SECRET]
  else
    provider :facebook, '1310803142692405', 'b00a1a34ced98db7c9da5f99aa2f00ae'
  end
end