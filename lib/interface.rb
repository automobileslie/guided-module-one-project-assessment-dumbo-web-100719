class CommandLineInterface
    def greet
        puts                "Welcome to Poetry Finder!".red
        puts            "Find a place to fall in love with.".yellow
        puts            "Or learn to appreciate where you already are.".yellow
        puts            "With the help of poetry.".yellow
        puts         "What would you like to do?".red
        puts        "1. create a user id-- if so, enter 1".blue
        puts        "2. find a poem--if so, enter 2".blue
        puts        "3. add a poem to your collection--if so, enter 3".blue
        puts        "4. delete a poem from your collection--if so, enter 4".blue
        puts        "5. update whether or not you have read the poems in your collection--if so, enter 5".blue
        puts        "6. see your current collection--if so, enter 6".blue
        puts        "7. retrieve your user id--if so, enter 7".blue
        puts        "8. Enter anything else to exit the app.".blue

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
        else puts "Thanks for visiting Poetry Finder!"
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
        self.greet
    end

    def create_user
        puts "Welcome! Create a user id in order to start building a collection."
        puts "Enter your name."
        the_entered_name=STDIN.gets.chomp
        this_result=User.create(name: the_entered_name)
        puts "Here is your user_id: #{this_result.id}. Now you can start adding poems!"
        self.greet
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
                poem_instance.title
            end
            array_of_authors=output.map do |poem_instance|
                poem_instance.author
            end
            puts "Enjoy this/these poem(s) #{array_of_poem_titles} by this/these author(s) #{array_of_authors}!"
        else
        puts "I'm sorry; we currently do not have any poems about that place!"
        end
        self.greet
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
        self.greet
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
        self.greet
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
            puts "Okay, no problem. What is your user id?"
            this_users_id=STDIN.gets.chomp
            if this_poem_that_was_entered.user_id== this_users_id.to_i
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
        self.greet
    end

    def display_collection
        puts "What is your user id?"
        this_time_response=STDIN.gets.chomp
        the_user_id_entered=this_time_response.to_i

        if User.find_by(id: the_user_id_entered)
            collection_right_now=User.find_by(id: the_user_id_entered).poems
                the_poem_titles= collection_right_now.map do |poem_instance|
                    poem_instance.title #also display the users and authors
                end
                the_poem_place_instances= collection_right_now.map do |poem_instance|
                    poem_instance.place
                end
                #the above returns an array(because it is a map) of instances of places that the poems in the collection are associated with. In order to get just the location, I will need to do another map to pull out the location(s) associated with the poems.
                locations= the_poem_place_instances.map do |place_instance|
                    place_instance.location
                end
                the_user_instance= collection_right_now.map do |poem_instance|
                    poem_instance.user
                end   
                the_user_names=the_user_instance.map do |user_instance|
                    user_instance.name
                end
                the_author_names= collection_right_now.map do |poem_instance|
                    poem_instance.author
                end
                the_user_ids= collection_right_now.map do |poem_instance|
                    poem_instance.user_id
                end
                puts "This is the collection that belongs to #{the_user_names}, with id number(s): #{the_user_ids}."
                puts  "Poems: #{the_poem_titles}"
                puts "Authors: #{the_author_names}"
                puts "Locations of Poems: #{locations}"
                was_it_read=collection_right_now.map do |poem_instance|
                    poem_instance.read
                end
                if was_it_read.include?(true)
                    #This ends up being a kind of magic eight ball response. It is something I could work more on!
                    puts "Read or unread? At least some of your poems have been read."
                else puts "Read or unread? You either have no poems at the moment,"
                    puts  "or you have not finished reading all of the poems in your collection yet."
                    end 
            # end
        else 
            puts "I'm sorry. There is no record of this user id."
        end 
        self.greet
    end

end
