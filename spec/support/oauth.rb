module OmniAuthFixtures
  def self.facebook_response
    { provider: 'facebook',
      uid: 10_205_522_242_159_630,
      info:
         { email: 'thomas@craftacademy.se',
           name: 'Thomas Ochman',
           image: 'http://graph.facebook.com/v2.6/10205522242159630/picture', role: 'service_provider' },
      credentials:
         { token:
              'EAAXC253O740BANfJYLjz2LCzT1UcfuEsoHpZBMAifdiud8sulF2LIfjDy5BeGiNPEPQjUn7xpvAu0neqnGeoCAvCU2KIucyP5sYNQDaDtCj06UmOF2POEq8ZAajS2zaQ4B7uIIRgv4p3wlACmh9f9MsMnDZB6gZD',
           expires_at: 1_517_839_337,
           expires: true },
      extra:
         { raw_info:
              { name: 'Thomas Ochman', email: 'thomas@craftacademy.se', id: '10205522242159630' } } }
  end

  def self.end_user_facebook_response
    { provider: 'facebook',
      uid: 10_205_522_242_159_630,
      info:
         { email: 'thomas@craftacademy.se',
           name: 'Thomas Ochman',
           image: 'http://graph.facebook.com/v2.6/10205522242159630/picture' },
      credentials:
         { token:
              'EAAXC253O740BANfJYLjz2LCzT1UcfuEsoHpZBMAifdiud8sulF2LIfjDy5BeGiNPEPQjUn7xpvAu0neqnGeoCAvCU2KIucyP5sYNQDaDtCj06UmOF2POEq8ZAajS2zaQ4B7uIIRgv4p3wlACmh9f9MsMnDZB6gZD',
           expires_at: 1_517_839_337,
           expires: true },
      extra:
         { raw_info:
              { name: 'Thomas Ochman', email: 'thomas@craftacademy.se', id: '10205522242159630' } } }
  end

  def self.google_oauth2_response
    { provider: 'google_oauth2',
      uid: '100000000000000000000',
      info: { name: 'John Smith',
              email: 'john@example.com',
              first_name: 'John',
              last_name: 'Smith',
              image: 'https://lh4.googleusercontent.com/photo.jpg',
              urls: { google: 'https://plus.google.com/+JohnSmith' } },
      credentials: { token: 'TOKEN', refresh_token: 'REFRESH_TOKEN', expires_at: 1_496_120_719,
                     expires: true },
      extra: { id_token: 'ID_TOKEN',
               id_info: { azp: 'APP_ID',
                          aud: 'APP_ID',
                          sub: '100000000000000000000',
                          email: 'john@example.com',
                          email_verified: true,
                          at_hash: 'HK6E_P6Dh8Y93mRNtsDB1Q',
                          iss: 'accounts.google.com',
                          iat: 1_496_117_119,
                          exp: 1_496_120_719 },
               raw_info: { kind: 'plus#personOpenIdConnect',
                           gender: 'male',
                           sub: '100000000000000000000',
                           name: 'John Smith',
                           given_name: 'John',
                           family_name: 'Smith',
                           profile: 'https://plus.google.com/+JohnSmith',
                           picture: 'https://lh4.googleusercontent.com/photo.jpg?sz=50',
                           email: 'john@example.com',
                           email_verified: 'true',
                           locale: 'en',
                           hd: 'company.com' } } }
  end
end