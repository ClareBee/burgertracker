require ( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('../models/applyingdeal.rb')
require_relative('../models/restaurant.rb')
require_relative( '../models/burger.rb' )
require_relative( '../models/deal.rb' )

#this isn't needed as the routes bypass the index and show the deal on the deals/index
get '/applyingdeals' do
  @burgers = Burger.all
  @deals = Deal.all
  @applyingdeals = ApplyingDeal.all
  @restaurants = Restaurant.all
  erb (:"/applyingdeals/index")
end

#create
get '/applyingdeals/new' do
  @restaurants = Restaurant.all
  @deals = Deal.all()
  erb ( :"applyingdeals/new" )
end

get '/applyingdeals/new_burger' do
  @deal = Deal.find(params[:deal_id])
  @restaurant = @deal.restaurant()
  @burgers = @restaurant.burgers()
  erb (:"applyingdeals/new_burger")
end

post '/applyingdeals/new_burger' do
  @applyingdeal = ApplyingDeal.new(params)
  @applyingdeal.save
  erb ( :"applyingdeals/show")
end

#read
get '/applyingdeals/:id' do
  @restaurants = Restaurant.all()
  @deals = Deal.all()
  @burgers = Burger.all()
  @applyingdeal = ApplyingDeal.find(params['id'])
   erb( :"applyingdeals/show" )
 end

#update - this also isn't needed as you can only create or destroy applyingdeals
get '/applyingdeals/:id/edit' do
  @burgers = Burger.all()
  @deals = Deal.all()
  @applyingdeal = ApplyingDeal.find(params['id'])
  erb( :"applyingdeals/edit" )
end

post '/applyingdeals/:id' do
  @restaurants= Restaurant.all()
  @burgers = Burger.all()
  @deals = Deal.all()
  @applyingdeal = ApplyingDeal.new(params)
  @applyingdeal.update()
  redirect to("/applyingdeals")
end

#destroy
post '/applyingdeals/:id/delete' do
  deal = ApplyingDeal.find(params['id'])
  deal.delete()
  redirect to("/deals")
end
