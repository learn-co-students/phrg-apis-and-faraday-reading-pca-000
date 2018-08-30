class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '13RCAHEIINBT02T5IAT3YO43VIKI5FKXW5A5B0ZZPXMQCAD3'
        req.params['client_secret'] = '1FT1GS24LC1LHHRIDJERBHLBVEPJ2NT5ZKRUH5YUDYJIAAHC'
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

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
