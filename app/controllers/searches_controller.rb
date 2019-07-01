class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'SF5MMVUW1SJH4Y4NWPFYSCEVUNM3XW00MO4DKQZBGZGOI4M2'
        req.params['client_secret'] = 'ASSGQTCW3KW3OWLL0CSW34TPON4X1DS12ALY1QZ31ZNE03NK'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
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
# begin
    # @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    #     req.params['client_id'] = 'SF5MMVUW1SJH4Y4NWPFYSCEVUNM3XW00MO4DKQZBGZGOI4M2'
    #     req.params['client_secret'] = 'ASSGQTCW3KW3OWLL0CSW34TPON4X1DS12ALY1QZ31ZNE03NK'
    #     req.params['v'] = '20160201'
    #     req.params['near'] = params[:zipcode]
    #     req.params['query'] = 'coffee shop'
    #     req.options.timeout = 0
    #   end
    #   body = JSON.parse(@resp.body)
    #   if @resp.success?
    #     @venues = body["response"]["venues"]
    #   else
    #     @error = body["meta"]["errorDetail"]
    #   end

    # rescue Faraday::ConnectionFailed
    #   @error = "There was a timeout. Please try again."
    # end
    # render 'search'
