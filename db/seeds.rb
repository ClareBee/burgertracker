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

burger1 = Burger.new ({
  'name' => "The Classic",
  'restaurant_id' => restaurant2.id,
  'price' => 5.00,
  'veg' => FALSE
  })
burger1.save()

burger2 = Burger.new ({
  'name' => "Veggie",
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

deal1 = Deal.new ({
  'name' => "Monday Extravaganza",
  'restaurant_id' => restaurant1.id,
  'discount' => 50,
  'day' => "Monday"
  })
deal1.save()

deal2 = Deal.new ({
  'name' => "Quarter Off Quarterpounders",
  'restaurant_id' => restaurant2.id,
  'discount' => 25,
  'day' => "Monday"
  })
deal2.save()

deal3 = Deal.new ({
  'name'=> "Half Price Fridays",
  'restaurant_id' => restaurant1.id,
  'discount' => 30,
  'day' => "Friday"
  })
deal3.save()

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
  'burger_id' => burger3.id,
  'deal_id' => deal1.id
  })
applyingdeal3.save()

applyingdeal4 = ApplyingDeal.new ({
  'burger_id' => burger1.id,
  'deal_id' => deal2.id
  })
applyingdeal4.save()

binding.pry
nil
