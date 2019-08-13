class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params["client_id"] = "B2LWAPNVITZNTQ4FPGEF2O3NQEEK1IYASZ5SK2QDDVFLT1HR"
        req.params["client_secret"] = "2QWX0PUMKJ5EEF4KJWBKO2VR10XENW0O2KTCNLGEKXVFRRQR"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Pelease try again."
    end
    render "search"
  end
end
