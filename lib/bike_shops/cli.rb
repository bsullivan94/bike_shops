module BikeShops
  class CLI #class that runs the CLI. Outputs options to the screen and receives input from the user to help access other classes 
    def initialize
      @input = "" #initializes all input instances to an empty string
    end

    def start #instance method that starts the program and calls other instance methods used to access info for the app
      puts "Welcome to Brody's Bike Shops!"
      while @input != "exit" #conditional based on the validity of the choice returned by the ask_for_choice method
        set_location
        start_bike_shop_picker
      end
      goodbye
    end

    def set_location
      puts "Tell me your location so we can get those pedals turning!"
      @location = gets.chomp
      Shop.load_by_location(@location)
    end

    def start_bike_shop_picker
      list_bike_shops
      ask_for_choice
      while @input.downcase != "exit" && @input.downcase != "back" #conditionals that are used to either exit the program or go back to the main menu of the app
        if @input.downcase == "list"
          list_bike_shops
        elsif valid? #conditional that is checking the validity of input and displays the error message if it is not valid
          shop = Shop.find_by_number(@input)
          puts details(shop)
          Shop.sort_by_rating.collect { |shop| "#{shop.rating}" }
        else
          puts "Whoops! I didn't quite get that, try again?"
        end
        ask_for_choice
      end

    end

    def details(shop)
      <<-HEREDOC 
      #{shop.name} 
      has a rating of #{shop.rating}
      #{shop.location["address1"]} 
      #{shop.location["city"]} #{shop.location["state"]} #{shop.location["zip_code"]}
      Phone: #{shop.phone}
   
      HEREDOC
    end


    def list_bike_shops
      Shop.all.each.with_index(1) do |shop, index|
        puts "#{index}. #{shop.name}"
      end
    end

    def ask_for_choice #instance method that is asking the user to input the bike shop number in order to see more info about it
      list_choices
      @input = gets.strip
    end

    def list_choices
      puts [
        "To see more information about a bike shop, type its number and hit enter.",
        "If you'd like to view the list again, type 'list'.",
        "If you'd like to head back to the main menu for another search, type 'back'.",
        "If you'd like to exit the program, simply type 'exit'."
      ]
    end

    def valid? #instance method that returns as truthy or falsey based on whether the input that the user 
      #has chosen is a valid bike shop number in the list of bike shop objects
      @input.to_i.between?(1, Shop.all.length)
    end

    def goodbye
      puts "\nThanks for using Brody's Bike Shops. Cheers!"
    end
  end
end

# CLI Class Responsibilities 
  # Interacts with the User 
  # Prints Out Prompts 
  # Takes Input 
  # Decides What To Do With Data 
