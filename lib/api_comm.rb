require 'rest-client'
require 'json'
require 'pry'
require 'digest'

def fetch_marvel
  public_key = "5e8946f12e3dfaf42d0e54483983358e"
  private_key = "a449d1ddb8da13dfbd329ff8dc0d9747375a63e9"
  time = Time.now
  hash_soup = time.to_s + private_key + public_key
  hash = Digest::MD5.hexdigest hash_soup
  url_mine = "https://gateway.marvel.com/v1/public/comics?ts=#{time.to_s}&apikey=#{public_key}&hash=#{hash}"
  response = RestClient.get("https://gateway.marvel.com/v1/public/comics?ts=#{time.to_s}&apikey=#{public_key}&hash=#{hash}")
  marv_response = JSON.parse(response)
end


