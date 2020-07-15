module BikeShops
  class API
    API_HOST =  "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"

    def self.api_key

      begin
        @@key = File.open(File.expand_path("~/.yelp-api-key")).read.strip
      rescue 
        puts "Whoops! Looks like you haven't added your Yelp API key yet! You can go sign up for one by following these instructions: https://ultimateelementor.com/docs/get-yelp-api-key/. Once you're done, come back and paste your key in here:"
        @@key = gets.strip 
        File.open(File.expand_path("~/.yelp-api-key"), "w") do |file|
          file.print @@key
        end
      end
      @@key
    end

    def self.yelp_search(term, location)
      url = "#{API_HOST}#{SEARCH_PATH}"
      params = {
        term: term,
        location: location
      }
    
      response = HTTP.auth("Bearer #{api_key}").get(url, params: params)
      JSON.parse(response)["businesses"]
    end

    def self.get_reviews(business_id)
      # https://api.yelp.com/v3/businesses/{id}/reviews
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}/reviews"

      response = HTTP.auth("Bearer #{api_key}").get(url)
      JSON.parse(response)["reviews"]
    end
  end
end