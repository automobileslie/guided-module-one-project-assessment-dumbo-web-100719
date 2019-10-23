class CommandLineInterface
    def greet
        puts                "Welcome to Poetry Finder!".red
        puts         "What would you like to do?".yellow 
        puts        "1. create a user id-- if so, enter 1".blue
        puts        "2. find a poem--if so, enter 2".blue
        puts        "3. add a poem to your collection--if so, enter 3".blue
        puts        "4. delete a poem from your collection--if so, enter 4".blue
        puts        "5. update whether or not you have read the poems in your collection--if so, enter 5".blue
        puts        "6. see your current collection--if so, enter 6".blue
        puts        "7. retrieve your user id--if so, enter 7".blue

        the_first_response=STDIN.gets.chomp

        if the_first_response== "1"
            self.create_user
        elsif the_first_response== "2"
            self.find_a_poem
        elsif the_first_response== "3"
            self.add_to_collection
        elsif the_first_response== "4"
            self.delete_from_collection
        elsif the_first_response== "5"
            self.update_status  
        elsif the_first_response== "6"
            self.display_collection
        elsif the_first_response== "7"
            self.retrieve_user_id
        end
    end

    def retrieve_user_id
        puts "What is your name?" 
        this_time_the_name=STDIN.gets.chomp
        if User.find_by(name: this_time_the_name)
            the_users_name_entered=User.find_by(name:this_time_the_name)
            puts "This is your user id: #{the_users_name_entered.id}."
        else 
            puts "I'm sorry. We don't have a user id for that name."
        end
    end

    def create_user
        puts "Welcome! Create a user id in order to start building a collection."
        puts "Enter your name."
        the_entered_name=STDIN.gets.chomp
        this_result=User.create(name: the_entered_name)
        puts "Here is your user_id: #{this_result.id}. Now you can start adding poems!"
    end

    def find_a_poem
        puts "Enter a location."
        puts "Those we currently have poems for include:"
        puts "Somewhere, Nowhere, Everywhere, Anywhere, In the Channel, In the Lake, and New York"
        entered_value=STDIN.gets.chomp

        if Place.find_by(location:entered_value)
            result=Place.find_by(location:entered_value).id
            output=Poem.find_by(place_id: result).title
            another_output=Poem.find_by(place_id: result).author
            puts "Enjoy this poem \"#{output}\" by #{another_output}!"

        else
        puts "I'm sorry; we currently do not have any poems about that place!"
        end
    end

    def add_to_collection
        puts "What poem would you like to add to your collection?"
        the_response=STDIN.gets.chomp

        if Poem.find_by(title: the_response)
            puts "Great. What is your user id?"
            the_users_id=STDIN.gets.chomp
            the_poem_that_was_entered=Poem.find_by(title: the_response)
            the_poem_that_was_entered.update(user_id: the_users_id.to_i)
            puts "Congratulations! This poem is now in your collection."
        else
            puts "I'm sorry! That poem is not currently available."
        end
    end

    def delete_from_collection
        puts "What poem would you like to delete from your collection?"
         the_response=STDIN.gets.chomp
        if Poem.find_by(title: the_response)
            the_poem_that_was_entered=Poem.find_by(title: the_response)
            puts "Okay, no problem. What is your user id?"
            the_users_id=STDIN.gets.chomp
            if the_poem_that_was_entered.user_id== the_users_id.to_i
            the_poem_that_was_entered.update(user_id: nil)
            puts "I hope you enjoyed the poem. It is no longer in your collection."
            else
            puts "That poem is not currently a part of your collection, so there is no need to delete it."
            end
        else
         puts "We actually do not have a record of that poem."
        end
     end

    def update_status
        puts "Would you like to change the status of your poem..."
        puts "1. to 'read'? If so, type 'read'."
        puts "2. or to 'unread'? If so, type 'unread'."
        this_response=STDIN.gets.chomp

        puts "Okay. What poem's status would you like to update?"
        the_next_response=STDIN.gets.chomp

        if Poem.find_by(title: the_next_response)
            this_poem_that_was_entered=Poem.find_by(title: the_next_response)
            puts "Okay, no problem. What is your user id?"
            this_users_id=STDIN.gets.chomp
            if this_poem_that_was_entered.user_id== this_users_id.to_i
                if this_response== "read"
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
    end

    def display_collection
        #This is not working properly right now for every user, so I am going to work on it more!
        puts "What is your user id?"
        this_time_response=STDIN.gets.chomp

        if Poem.find_by(user_id: this_time_response)
            collection_right_now=Poem.find_by(user_id:this_time_response)
            puts "This is your current collection. I hope you are enjoying the poems."
            puts  "Poems: \"#{collection_right_now.title}\""
            puts "Authors: #{collection_right_now.author}"
            if collection_right_now.read== true
            puts "Read or unread? read"
            else puts "Read or unread? unread"
            end 
        else 
            puts "I'm sorry. There is no record of this user id."
        end 
    end
end
