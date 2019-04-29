require 'rails_helper'

RSpec.describe CoordinatesController, type: :controller do
  let(:user) { User.create }
  # it 'should not allow unauthorized access' do
  #   get :index, params: { query: 'Berlin' }
  #   expect(response).not_to be_successful
  # end

  it 'should render { "error": "400 Bad Request" } when query = ""' do
    get(:index, params: { query: '' })
    parsed_response = JSON.parse(response.parsed_body)
    expect(parsed_response['error']).to eq('400 Bad Request')
  end

  it 'should render { "error": "404 Not Found" } when query = "qqqqqq"' do
    sleep 1
    get :index, params: { query: 'qqqqqq' }
    parsed_response = JSON.parse(response.parsed_body)
    expect(parsed_response['error']).to eq('404 Not Found')
  end

  it 'should render correct coordinates when query = "Berlin"' do
    sleep 1
    get :index, params: { query: 'Berlin' }
    parsed_response = JSON.parse(response.parsed_body)
    expect(parsed_response['latitude']).to eq('52.5170365')
    expect(parsed_response['longitude']).to eq('13.3888599')
  end

  it 'should render correct coordinates when query = "Checkpoint Charlie"' do
    sleep 1
    get :index, params: { query: 'Checkpoint Charlie' }
    parsed_response = JSON.parse(response.parsed_body)
    expect(parsed_response['latitude']).to eq('52.5075459')
    expect(parsed_response['longitude']).to eq('13.3903685')
  end

  it 'should render coorect coordinates when query = "Dessauer Str. 28"' do
    sleep 1
    get :index, params: { query: 'Dessauer Str. 28' }
    parsed_response = JSON.parse(response.parsed_body)
    expect(parsed_response['latitude']).to eq('52.5042626')
    expect(parsed_response['longitude']).to eq('13.3784287')
  end
end
