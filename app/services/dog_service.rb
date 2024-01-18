require 'net/http'
class DogService
  API_URL = "https://dog.ceo/api/breed/%s/images"

  attr_accessor :search_term
  def initialize(search_term)
    @search_term = search_term
  end
  def fetch_dog
    uri = URI(API_URL % search_term)
    res = Net::HTTP.get_response(uri)
    return nil unless res.is_a?(Net::HTTPSuccess)
    body = JSON.parse(res.body)
    msg = body['message']
    msg&.sample
  rescue
    nil
  end
end