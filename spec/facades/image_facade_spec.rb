require 'rails_helper'

RSpec.describe ImageFacade do
  it 'returns an image object' do
    location = 'denver,co'

    body = File.read('spec/fixtures/image_data_denver.json')
    stub_request(:get, "#{ENV['IMAGE_URL']}/images/search?count=1&q=#{location}&safeSearch=Strict").
         with(headers: { 'Ocp-Apim-Subscription-Key'=>ENV['IMAGE_API_KEY'] }).
         to_return(status: 200, body: body, headers: {})

    result = ImageFacade.background_of_location(location)

    expect(result).to be_a(Image)
    expect(result.image_url).to be_a(String)
    expect(result.source).to be_a(String)
  end
end
