require 'open-uri'
class CoordinatesController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate

  def index
    begin
      response = open("https://eu1.locationiq.com/v1/search.php?key=f534c86034a1d0&q=#{params[:query]}&format=json").read
      parsed_response = JSON.parse(response)
        render json: {
          latitude: parsed_response[0]['lat'],
          longitude: parsed_response[0]['lon']
        }
    rescue OpenURI::HTTPError => error
      if error.io.status[0] == '404'
        render json: {
          error: error.message.to_s
        }, status: :not_found
      elsif error.io.status[0] == '400'
        render json: {
          error: error.message.to_s
        }, status: :bad_request
      end
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end
end
