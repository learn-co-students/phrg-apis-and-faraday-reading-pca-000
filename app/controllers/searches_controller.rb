class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '2G5S0ABXNB53BPVPAHJZAXZUZBTXK4NOKH0SX2D1INE3W4RT'
      req.params['client_secret'] = '3UILQFMZ1DEJYQZRSONVKC3WBWXV1XBA3NODVQS1LK54KLAO'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end
  render 'search'
end
