require 'rails_helper'

RSpec.describe TrailService do
  it 'returns a list of json data on nearby trails' do
    location = 'denver,co'
    latitude = 39.738453
    longitude = -104.984853

    trail_body = File.read('spec/fixtures/trails_data_denver.json')
    stub_request(:get, "#{ENV['TRAIL_URL']}/get-trails?key=#{ENV['TRAIL_API_KEY']}&lat=#{latitude}&lon=#{longitude}&maxDistance=10").
      to_return(status: 200, body: trail_body, headers: {})

    result = TrailService.trails_by_location(latitude, longitude)

    expect(result).to be_a(Hash)
    expect(result).to have_key(:trails)
    expect(result[:trails]).to be_an(Array)
    expect(result[:trails].count).to eq(1)
    expect(result[:trails].first).to have_key(:name)
    expect(result[:trails].first[:name]).to be_a(String)
    expect(result[:trails].first).to have_key(:summary)
    expect(result[:trails].first[:summary]).to be_a(String)
    expect(result[:trails].first).to have_key(:difficulty)
    expect(result[:trails].first[:difficulty]).to be_a(String)
    expect(result[:trails].first).to have_key(:location)
    expect(result[:trails].first[:location]).to be_a(String)
    expect(result[:trails].first).to have_key(:latitude)
    expect(result[:trails].first[:latitude]).to be_a(Numeric)
    expect(result[:trails].first).to have_key(:longitude)
    expect(result[:trails].first[:longitude]).to be_a(Numeric)
  end
end
