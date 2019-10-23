#methods to delete all instances in the db
User.destroy_all
Place.destroy_all
Poem.destroy_all



amy=User.create(name: "Amy")
shery=User.create(name: "Shery")
vicki=User.create(name: "Vicki")
roy=User.create(name: "Roy")
ginny=User.create(name: "Ginny")
urban=User.create(name: "Urban")
carlie=User.create(name: "Carlie")
shari=User.create(name: "Shari")
ret=User.create(name: "Ret")
ralph=User.create(name: "Ralph")

somewhere=Place.create(location: "Somewhere")
nowhere=Place.create(location: "Nowhere")
everywhere=Place.create(location: "Everywhere")
anywhere=Place.create(location: "Anywhere")
elsewhere=Place.create(location: "Elsewhere")
in_the_channel=Place.create(location: "In the Channel")
in_the_lake=Place.create(location: "In the Lake")
new_york=Place.create(location: "New York")

lake_poem=Poem.create(title: "Lake Poem", author: "Lake Poetess", read: true, place_id: in_the_lake.id, user_id: roy.id)
channel_poem=Poem.create(title: "Channel Poem", author: "Channel Poetess", read: true, place_id: in_the_channel.id, user_id: vicki.id)
somewhere_poem=Poem.create(title: "Somewhere Poem", author: "Somewhere Poet", read: false, place_id: somewhere.id, user_id: urban.id)
anywhere_poem=Poem.create(title: "Anywhere Poem", author: "Anywhere Poet", read: false, place_id: anywhere.id, user_id: ginny.id)
nowhere_poem=Poem.create(title: "Nowhere Poem", author: "Nowhere Poetess", read: false, place_id: nowhere.id, user_id: shery.id)
everywhere_poem=Poem.create(title: "Everywhere Poem", author: "Everywhere Poetess", read: true, place_id: everywhere.id, user_id: amy.id)
elsewhere=Poem.create(title: "Elsewhere Poem", author: "Elsewhere Poet", read: false, place_id: elsewhere.id, user_id: ret.id)
recuerdo=Poem.create(title: "Recuerdo", author: "Edna St. Vincent Millay", place_id: new_york.id, user_id: ralph.id)
crossing_brooklyn_ferry=Poem.create(title: "Crossing Brooklyn Ferry", author: "Walt Whitman", place_id: new_york.id, user_id: shari.id)
