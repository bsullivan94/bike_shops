module BikeShops
  class Shop
    attr_accessor :id, :name, :review_count, :rating, :location, :price, :phone # define attributes for mass assignment from hash
    
    @@all = []

    def initialize(attributes={})
      attributes.each do |attribute_name, attribute_value|
        if self.respond_to?("#{attribute_name}=") #is it there?
          self.send("#{attribute_name}=", attribute_value)
        end
      end
    end

    def self.all #provide access to the @@all array ('getter')
      @@all
    end

    def self.find_by_number(number)
      self.all[number.to_i - 1]
    end

    def self.load_by_location(location) 
      location_based_search_results = API.yelp_search("bike shop", location)
      #now call create to instantiate and load objects into @@all, overwrites contents for each location entered by user
      @@all = self.create_from_search_results(location_based_search_results)
    end

    def self.create_from_search_results(search_results)
      search_results.map do |shop_info_hash|
        self.new(shop_info_hash)
      end
    end

    def details
      <<-HEREDOC
      #{self.name} 
      has a rating of #{self.rating}
      #{self.location["address1"]} 
      #{self.location["city"]} #{self.location["state"]} #{self.location["zip_code"]}
      Phone: #{self.phone}
   
      HEREDOC
    end
  end
end

#Shop Class Responsibilities 
  # Describes The Objects That Are Created, Stored and Accessed 
    # What Are Their Attributes?
    # How Do We Display Them In A List? 
    # How Do We Display Details About Them?     