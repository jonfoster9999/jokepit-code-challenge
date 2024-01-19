require 'rails_helper'

RSpec.describe DogService do

  describe '#initialize' do
    it 'takes a breed' do
      dog_service = described_class.new('some-breed')
      expect(dog_service.breed).to eq('some-breed')
    end

    it 'throws an error without the search term' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  describe '#fetch_dog' do
    let(:service) { described_class.new('some-breed') }
    let(:mock_dog_images) { %w[https://fake.com/dog1.jpg https://fake.com/dog2.jpg] }

    context 'when the request is successful' do
      let(:mock_response) { { 'message' => mock_dog_images }.to_json }

      before do
        allow(Net::HTTP).to receive(:get_response).and_return(double('response', is_a?: Net::HTTPSuccess, body: mock_response))
      end

      it 'returns a random dog image URL' do
        dog_url = service.fetch_dog
        expect(mock_dog_images).to include(dog_url)
      end
    end

    context 'when the request fails' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_raise(StandardError.new('Some error'))
      end

      it 'returns nil' do
        expect(service.fetch_dog).to be_nil
      end
    end

    context 'when the response is not a success' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(double('response', is_a?: false))
      end

      it 'returns nil' do
        expect(service.fetch_dog).to be_nil
      end
    end

    context 'when the response body is not valid JSON' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(double('response', is_a?: Net::HTTPSuccess, body: 'invalid_json'))
      end

      it 'returns nil' do
        expect(service.fetch_dog).to be_nil
      end
    end
  end
end