module BikeShops
  class CLI
    def initialize
      @input = ""
    end

    def start 
      puts "Welcome to Brody's Bike Shops!"
      while @input != "exit"
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
      while @input != "exit" && @input != "back"
        if @input == "list"
          list_bike_shops
        elsif valid?
          puts Shop.find_by_number(@input).details
        else
          puts "Whoops! I didn't quite get that, try again?"
        end
        ask_for_choice
      end
    end


    def list_bike_shops
      Shop.all.each.with_index(1) do |shop, index|
        puts "#{index}. #{shop.name}"
      end
    end

    def ask_for_choice
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

    def valid?
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
