class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'L4R0DJ14HYFECXH352NZYS0VXCVF1K3LCY4VRJHXF0U34DKX'
      req.params['client_secret'] = 'OD0WM3NFTCRYJZYYXFEFLJ34V02FL2L5VDY5QJT0K2KNVTLR'
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
end
