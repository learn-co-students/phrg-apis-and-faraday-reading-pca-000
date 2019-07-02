class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "3J0DNO5LIJ1PMC4MCDKHNG3A4HTOKMTJ3YPDNFU2F32OUOMK"
      req.params['client_secret'] = "KU0QSQ5ZOXP12EGRNXWGV5MAZZBGI1ZWUEME3PUYC1FHDGC5"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
   body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end

