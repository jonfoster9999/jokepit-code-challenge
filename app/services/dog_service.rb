require 'net/http'
class DogService
  API_URL = "https://dog.ceo/api/breed/%s/images"
  attr_accessor :breed
  def initialize(breed)
    @breed = breed
  end

  def fetch_dog
    res = Net::HTTP.get_response(search_uri)
    return nil unless res.is_a?(Net::HTTPSuccess)
    body = JSON.parse(res.body)
    msg = body['message']
    # take a random dog image from the array.
    msg&.sample
  rescue
    nil
  end

  private

  def search_uri
    @search_uri ||= URI(API_URL % breed)
  end
end