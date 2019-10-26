class CommandLineInterface
    def greet
        puts                "Welcome to Poetry Finder!".red
        puts            "Find a place to fall in love with.".yellow
        puts            "Or learn to appreciate where you already are.".yellow
        puts            "With the help of poetry.".yellow

        puts            "To create a user id, enter 1".blue
        puts            "To log in, enter 2".blue
        puts            "To exit the app, enter exit" 

        the_user_responded=STDIN.gets.chomp

        if the_user_responded== "1"
            self.create_user  
        elsif the_user_responded== "2"
            puts "Please enter your user id."
            @the_users_id=STDIN.gets.chomp.to_i
            if User.find_by(id: @the_users_id)
                puts "Welcome back!" 
                self.main_menu
            else 
                puts "I'm sorry! That user id is invalid."
                self.greet
            end
        else puts "Thanks for visiting Poetry Finder!"
            exit!
        end   
    end

    def main_menu
        puts         "What would you like to do?".red
        puts        "1. find a poem--if so, enter 1".blue
        puts        "2. add a poem to your collection--if so, enter 2".blue
        puts        "3. delete a poem from your collection--if so, enter 3".blue
        puts        "4. update whether or not you have read the poems in your collection--if so, enter 4".blue
        puts        "5. see your current collection--if so, enter 5".blue
        # puts        "6. retrieve your user id--if so, enter 6".blue
        puts        "6. Enter exit to return to the login page.".blue #this currently doesn't work
    
            selection=STDIN.gets.chomp
    
            if selection== "1"
                self.find_a_poem
            elsif selection== "2"
                self.add_to_collection
            elsif selection== "3"
                self.delete_from_collection
            elsif selection== "4"
                self.update_status  
            elsif selection== "5"
                self.display_collection
            # elsif the_first_response== "6"
            #     self.retrieve_user_id
            end
            self.greet
    end

    # def retrieve_user_id
    #     puts "What is your name?" 
    #     this_time_the_name=STDIN.gets.chomp
    #     if User.find_by(name: this_time_the_name)
    #         the_users_name_entered=User.find_by(name:this_time_the_name)
    #         puts "This is your user id: #{the_users_name_entered.id}."
    #     else 
    #         puts "I'm sorry. We don't have a user id for that name."
    #     end
    #     self.greet
    # end

    def create_user
        puts "Welcome! Create a user id in order to start building a collection."
        puts "Enter your name."
        the_entered_name=STDIN.gets.chomp
        this_result=User.create(name: the_entered_name)
        puts "Here is your user_id: #{this_result.id.to_i}. Now you can start adding poems!"
        self.main_menu
    end

    def find_a_poem
        puts "Enter a location."
        puts "Those we currently have poems for include:"
        puts "Somewhere, Nowhere, Everywhere, Anywhere, Elsewhere, In the Channel, In the Lake, and New York"
        entered_value=STDIN.gets.chomp

        if Place.find_by(location:entered_value)
            result=Place.find_by(location:entered_value).id
            output=Poem.where(place_id: result)
            array_of_poem_titles= output.map do |poem_instance|
            puts "Enjoy \"#{poem_instance.title}\" by #{poem_instance.author}!"
            end
        else
        puts "I'm sorry; we currently do not have any poems about that place!"
        end
            self.main_menu
    end

    def add_to_collection
        puts "What poem would you like to add to your collection?"
        the_response=STDIN.gets.chomp

        if Poem.find_by(title: the_response)
            
            the_poem_that_was_entered=Poem.find_by(title: the_response)
            if the_poem_that_was_entered.user_id== @the_users_id
                puts "That poem is already in your collection! No need to add it."
            else
            the_poem_that_was_entered.update(user_id: @the_users_id)
            the_poem_that_was_entered.update(read: false)
            puts "Congratulations! This poem is now in your collection."
            end
        else
            puts "I'm sorry! That poem is not currently available."
        end
            self.main_menu
    end

    def delete_from_collection
        puts "What poem would you like to delete from your collection?"
         the_response=STDIN.gets.chomp
        if Poem.find_by(title: the_response)
            the_poem_that_was_entered=Poem.find_by(title: the_response)
            if the_poem_that_was_entered.user_id== @the_users_id
            the_poem_that_was_entered.update(user_id: nil)
            puts "I hope you enjoyed the poem. It is no longer in your collection."
            else
            puts "That poem is not currently a part of your collection, so there is no need to delete it."
            end
        else
         puts "We actually do not have a record of that poem."
        end
            self.main_menu
     end

    def update_status
        puts "Would you like to change the status of your poem..."
        puts "1. to 'read'? If so, enter 1."
        puts "2. or to 'unread'? If so, enter 2."
        this_response=STDIN.gets.chomp

        puts "Okay. What poem's status would you like to update?"
        the_next_response=STDIN.gets.chomp

        if Poem.find_by(title: the_next_response)
            this_poem_that_was_entered=Poem.find_by(title: the_next_response)
            if this_poem_that_was_entered.user_id== @the_users_id
                if this_response== "1"
                    this_poem_that_was_entered.update(read: true)
                    puts "Excellent. The poem status was updated to 'read'."
                else
                    this_poem_that_was_entered.update(read: false)
                    puts "Excellent. The poem status was changed to 'unread'."
                end
            else
            puts "That poem is not currently a part of your collection, so you cannot update the status of it."
            end
        else
            puts "We actually do not have a record of that poem. Please try again."
        end
            self.main_menu
    end

    def display_collection
            
        if User.find_by(id: @the_users_id).poems != []
            User.find_by(id: @the_users_id).poems.map do |an_instance|
                puts "\"#{poems_titles=an_instance.title}\" by #{the_author_names=an_instance.author}"
                puts "Location of Poem: #{the_poems_locations=an_instance.place.location}"
                was_it_read=an_instance.read
                if was_it_read== true
                puts "Read or unread? Read"
                else puts "Read or unread? Unread"
                end 
            end

        else puts "You do not currently have any poems in your collection!"
        end
        self.main_menu
    end

end
