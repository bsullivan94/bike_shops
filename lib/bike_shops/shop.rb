module BikeShops
  class Shop #class that takes in the input from the API and creates bike shop objects that can be parsed and sent to the cli for output
    attr_accessor :id, :name, :review_count, :rating, :location, :price, :phone # creates getter & setter methods for each hash key received from the api shop info hash 
    
    @@all = []

    def initialize(attributes={}) #allows us to produce new instances of each bike shop
      attributes.each do |attribute_name, attribute_value| #iterates over each hash assigning each key as an attribute name 
        if self.respond_to?("#{attribute_name}=") #and each key value as the attribute value using the send method
          self.send("#{attribute_name}=", attribute_value)
        end
      end
    end

    def self.all #class method that provides access to the class array @@all ('getter')
      @@all
    end

    def self.find_by_number(number) #class method that takes in the choice of the user and then finds the bike shop object associated with it within the all array
      self.all[number.to_i - 1]
    end

    def self.load_by_location(location) #class method that passes input from the user into the class methods from the api class based on a conditional of 
      location_based_search_results = API.yelp_search("bike shop", location) #whatever city, state, etc. the user chose
      #now call create to instantiate and load objects into @@all, overwrites contents for each location entered by user
      self.create_from_search_results(location_based_search_results)
    end

    def self.create_from_search_results(search_results) #class method that is used to create new instances by iterating over the shop info hash
      search_results.each do |shop_info_hash| #use map to collect the results and return a new array of the results 
        @@all << self.new(shop_info_hash)
      end
    end

    def self.sort_by_rating
      all.sort_by {|shop| shop.rating }
    end
  end
end
#create a class method called sort_by_rating that stores all the existing shops by rating and displays them by rating
#integrate into CLI


#Shop Class Responsibilities 
  # Describes The Objects That Are Created, Stored and Accessed 
    # What Are Their Attributes?
    # How Do We Display Them In A List? 
    # How Do We Display Details About Them?     