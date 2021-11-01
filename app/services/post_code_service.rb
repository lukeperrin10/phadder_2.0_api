# frozen_string_literal: true

require 'rest-client'
module PostCodeService
  # URL = 'http://yourmoneyisnowmymoney.com/api/zipcodes'
  URL = 'http://api.zippopotam.us/se/'
  def self.get_location(post_code)
    #response = JSON.parse(RestClient.get(URL, params: { zipcode: post_code }).body)    
    response = JSON.parse(RestClient.get(URL + post_code.delete(' ')))
    #response['results'].first.symbolize_keys
    response['places'].first.symbolize_keys
  end

  def self.to_coordinates(post_code)
    result = PostCodeService.get_location(post_code)
    [result[:latitude].to_f, result[:longitude].to_f]
  end
end
