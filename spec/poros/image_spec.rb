require 'rails_helper'

RSpec.describe Image do
  it 'can create a image object' do
    raw_data = File.read('spec/fixtures/image_data_denver.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    forecast = Image.new(parsed_data)

    expect(forecast).to be_a(Image)
    expect(forecast.image_url).to be_a(String)
    expect(forecast.source).to be_a(String)
  end
end
