require_relative( '../models/restaurant.rb' )
require_relative( '../models/burger.rb' )
require_relative( '../models/deal.rb')
require_relative( '../models/applyingdeal.rb' )
require('pry-byebug')

ApplyingDeal.delete_all()
Deal.delete_all()
Burger.delete_all()
Restaurant.delete_all()

restaurant1 = Restaurant.new ({
  'name' => "Bob's Burgers",
  'location' => "14 Gordon Street",
  'rating' => 3
})
restaurant1.save()

restaurant2 = Restaurant.new ({
  'name' => "Burgerama",
  'location' => "56 Chapel Hill",
  'rating' => 4
  })
restaurant2.save()

restaurant3 = Restaurant.new ({
  'name' => "Patty's Buns",
  'location' => "2 Main Square",
  'rating' => 1
  })
restaurant3.save()

burger1 = Burger.new ({
  'name' => "The Classic",
  'restaurant_id' => restaurant1.id,
  'price' => 5.00,
  'veg' => FALSE
  })
burger1.save()

burger2 = Burger.new ({
  'name' => "The Beet Goes On",
  'restaurant_id' => restaurant1.id,
  'price' => 4.00,
  'veg' => TRUE
  })
burger2.save()

burger3 = Burger.new ({
  'name' => "Bacon Melt",
  'restaurant_id' => restaurant1.id,
  'price' => 8.00,
  'veg' => FALSE
  })
burger3.save()

burger4 = Burger.new({
  'name' => "Swiss Melt",
  'restaurant_id' => restaurant1.id,
  'price' => 6.50,
  'veg' => FALSE
  })
burger4.save()

burger5 = Burger.new({
  'name' => "Spicy Bean",
  'restaurant_id' => restaurant2.id,
  'price' => 5.50,
  'veg' => TRUE
  })
burger5.save()

burger6 = Burger.new({
  'name' => "Triple Cheese Inferno",
  'restaurant_id' => restaurant2.id,
  'price' => 6.00,
  'veg' => FALSE
  })
burger6.save()

burger7 = Burger.new ({
  'name' => "Burgerama Special",
  'restaurant_id' => restaurant2.id,
  'price' => 8.00,
  'veg' => FALSE
  })
burger7.save()

burger8 = Burger.new ({
  'name' => "Tofu Tower",
  'restaurant_id' => restaurant2.id,
  'price' => 7.00,
  'veg' => TRUE
  })
burger8.save()

burger9 = Burger.new ({
  'name' => "Patty's Beefcake",
  'restaurant_id' => restaurant3.id,
  'price' => 6.00,
  'veg' => FALSE
  })
burger9.save()

burger10 = Burger.new ({
  'name' => "Patty's Potato Patty",
  'restaurant_id' => restaurant3.id,
  'price' => 4.50,
  'veg' => TRUE
  })
burger10.save()

burger11 = Burger.new ({
  'name' => 'Blue Cheese Sleaze',
  'restaurant_id' => restaurant3.id,
  'price' => 8.00,
  'veg' => FALSE
  })
burger11.save()

deal1 = Deal.new ({
  'name' => "Monday Extravaganza",
  'restaurant_id' => restaurant1.id,
  'discount' => 50,
  'day' => "Monday"
  })
deal1.save()

deal2 = Deal.new ({
  'name' => "Quarter Off Quarterpounders",
  'restaurant_id' => restaurant1.id,
  'discount' => 25,
  'day' => "Wednesday"
  })
deal2.save()

deal3 = Deal.new ({
  'name'=> "Half Price Fridays",
  'restaurant_id' => restaurant2.id,
  'discount' => 50,
  'day' => "Friday"
  })
deal3.save()

deal4 = Deal.new ({
  'name' => "Half Off Happy Hour",
  'restaurant_id' => restaurant2.id,
  'discount' => 50,
  'day' => "Friday"
  })
deal4.save()

deal5 = Deal.new ({
  'name' => "Patty's Bonanza",
  'restaurant_id' => restaurant3.id,
  'discount' => 75,
  'day' => "Sunday"
  })
deal5.save()

applyingdeal1 = ApplyingDeal.new ({
  'burger_id' => burger1.id,
  'deal_id' => deal1.id
  })
applyingdeal1.save()

applyingdeal2 = ApplyingDeal.new ({
  'burger_id' => burger2.id,
  'deal_id' => deal1.id
  })
applyingdeal2.save()

applyingdeal3 = ApplyingDeal.new ({
  'burger_id' => burger4.id,
  'deal_id' => deal2.id
  })
applyingdeal3.save()

applyingdeal4 = ApplyingDeal.new ({
  'burger_id' => burger5.id,
  'deal_id' => deal3.id
  })
applyingdeal4.save()

applyingdeal5 = ApplyingDeal.new ({
  'burger_id' => burger7.id,
  'deal_id' => deal4.id
  })
applyingdeal5.save()

applyingdeal6 = ApplyingDeal.new ({
  'burger_id' => burger9.id,
  'deal_id' => deal5.id
  })
applyingdeal6.save()

binding.pry
nil
