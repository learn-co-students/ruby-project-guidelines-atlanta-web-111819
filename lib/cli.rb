class Interface

    def welcome_message
        puts "Welcome to FoodLocker"
        puts "Please Sign in or Signup"
        puts "Sign in, type: signin"
        puts "Sign up, type: signup"
        log_in_input = get_valid_input(2)
        
    end

    def get_valid_input(option_num)
        puts "Please enter a number between 1 and #{option_num}"
        user_input = self.input.to_i
        if user_input >= 1 && user_input <= option_num
            user_input
        else
            self.get_valid_input(option_num)
        end
    end

    def input
        gets.strip
    end

end