require 'rails_helper'

RSpec.describe Coordinate do
  it 'can create a coordinat object' do
    latitude = 25.0343
    longitude = 77.3963
    data = {
            results: [{
              locations: [{
                latLng: {
                  lat: latitude,
                  lng: longitude
                }
              }]
            }]
          }
    coordinate = Coordinate.new(data)
    expect(coordinate).to be_a(Coordinate)
    expect(coordinate.latitude).to eq(latitude)
    expect(coordinate.longitude).to eq(longitude)
  end
end
