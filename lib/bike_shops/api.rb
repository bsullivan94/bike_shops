module BikeShops
  class API
    API_HOST =  "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/" # trailing / because we append the business id to the path

    def self.api_key
      # this method will retrieve the API KEY stored in a file called .yelp_api_key in our root 
          # directory. If the file doesn't exist it will ask us to enter an API key to the terminal 
          # and store our input in that file so that it will be read next time we run the program.
      begin
        @@key = File.open(File.expand_path("~/.yelp-api-key")).read.strip
      rescue 
        puts "Whoops! Looks like you haven't added your Yelp API key yet! You can go sign up for one by following these instructions: https://ultimateelementor.com/docs/get-yelp-api-key/. Once you're done, come back and paste your key in here:"
        @@key = gets.strip #stores key 
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
  end
end

#JSON.parse(response) provides an array of hashes 

# API Class Responsibilities 
  # Interacts With The Internet To Get Data 
  # Returns Data As A Ruby Data Structure  (HTTP::Response) 
  # Endpoint is focused on the URL that is used to make a request. 