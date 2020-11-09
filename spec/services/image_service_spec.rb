require 'rails_helper'

RSpec.describe ImageService do
  it 'returns a json of image data based on location' do
    location = 'denver,co'

    body = File.read('spec/fixtures/image_data_denver.json')
    stub_request(:get, "#{ENV['IMAGE_URL']}/images/search?count=1&q=#{location}&safeSearch=Strict").
         with(headers: { 'Ocp-Apim-Subscription-Key'=>ENV['IMAGE_API_KEY'] }).
         to_return(status: 200, body: body, headers: {})

    result = ImageService.background_for_location(location)

    expect(result).to be_a(Hash)
    expect(result).to have_key(:value)
    expect(result[:value]).to be_an(Array)
    expect(result[:value].count).to eq(1)
    expect(result[:value].first).to have_key(:contentUrl)
    expect(result[:value].first[:contentUrl]).to be_a(String)
  end
end
