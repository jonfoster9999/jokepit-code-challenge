class DogsController < ApplicationController
  def fetch_dog
    @breed_name = params[:breed]&.downcase
    @dog_image_url = DogService.new(@breed_name).fetch_dog
    render partial: 'dog'
  end
end