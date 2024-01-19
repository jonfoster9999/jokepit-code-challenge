require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  render_views(true)

  describe '#fetch_dog' do
    let(:breed_name) { 'some-breed' }
    let(:dog_image_url) { 'https://fake.com/dog1.jpg' }

    context 'when the dog service finds an image' do
      before do
        allow_any_instance_of(DogService).to receive(:fetch_dog).and_return(dog_image_url)
        get :fetch_dog, params: { breed: breed_name }
      end

      it 'renders the dog partial with the expected image' do
        expect(response.body).to include("<img src=\"#{dog_image_url}\"")
      end
    end

    context 'when the dog service does NOT find an image' do
      before do
        allow_any_instance_of(DogService).to receive(:fetch_dog).and_return(nil)
        get :fetch_dog, params: { breed: breed_name }
      end

      it 'renders the dog partial with the expected image' do
        expect(response.body).to include("No Dogs Found.")
      end
    end
  end
end
