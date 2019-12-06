require 'rest-client'
require 'json'
require 'pry'
require 'digest'

PUBLIC_KEY = ENV["PUBLIC_KEY"]
PRIVATE_KEY = ENV["PRIVATE_KEY"]

def fetch_marvel(entry, offset = 0)
  time = Time.now
  hash_soup = time.to_s + PRIVATE_KEY + PUBLIC_KEY
  hash = Digest::MD5.hexdigest hash_soup
  # url_mine = "https://gateway.marvel.com/v1/public/characters?ts=#{time.to_s}&apikey=#{PUBLIC_KEY}&hash=#{hash}"
  response = RestClient.get("https://gateway.marvel.com/v1/public/#{entry}?ts=#{time.to_s}&apikey=#{PUBLIC_KEY}&hash=#{hash}&limit=100&offset=#{offset}")
  marv_response = JSON.parse(response)

  return marv_response
end

def fetch_comics(id_num)
  time = Time.now
  hash_soup = time.to_s + PRIVATE_KEY + PUBLIC_KEY
  hash = Digest::MD5.hexdigest hash_soup
  response = RestClient.get("http://gateway.marvel.com/v1/public/characters/#{id_num}/comics?ts=#{time.to_s}&apikey=#{PUBLIC_KEY}&hash=#{hash}")
  marv_response = JSON.parse(response)

  return marv_response
end

def fetch_characters(id_num)
  time = Time.now
  hash_soup = time.to_s + PRIVATE_KEY + PUBLIC_KEY
  hash = Digest::MD5.hexdigest hash_soup
  response = RestClient.get("http://gateway.marvel.com/v1/public/comics/#{id_num}/characters?ts=#{time.to_s}&apikey=#{PUBLIC_KEY}&hash=#{hash}")
  marv_response = JSON.parse(response)

  return marv_response
end

# binding.pry


