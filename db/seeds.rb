# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dummy_A = { name: "Sample Clay Piece A",
          details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras volutpat pellentesque leo vestibulum accumsan.",
          size: "10in x 10in x 10in",
          clay_type: "Stoneware",
          cone: 6,
          price: 26.00
}

dummy_B = { name: "Sample Clay Piece B",
          details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras volutpat pellentesque leo vestibulum accumsan.",
          size: "10in x 10in x 10in",
          clay_type: "Stoneware",
          fire_type: "Soda-fire",
          cone: 10,
          price: 35.00,
          quantity: 2
}

dummy_C = { name: "Sample Clay Piece C",
          details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras volutpat pellentesque leo vestibulum accumsan.",
          size: "2in x 2in x 2in",
          clay_type: "Stoneware",
          fire_type: "Wood-fire",
          cone: 10,
          price: 12.00,
          quantity: 10
}

a = Work.find_or_create_by(name: "Sample Clay Piece A")
a.update!(dummy_A)

b = Work.find_or_create_by(name: "Sample Clay Piece B")
b.update!(dummy_B)

c = Work.find_or_create_by(name: "Sample Clay Piece C")
c.update!(dummy_C)


