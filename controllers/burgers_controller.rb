require ( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/burger.rb' )
require_relative( '../models/restaurant.rb' )
require_relative( '../models/deal.rb' )
require_relative( '../models/applyingdeal.rb')


get '/burgers' do
  @restaurants = Restaurant.all
  @burgers = Burger.all
  @deals = Deal.all
  erb ( :"burgers/index" )
end

#create
get '/burgers/new' do
  @restaurants = Restaurant.all()
  erb ( :"burgers/new" )
end

post '/burgers' do
  @burger = Burger.new(params)
  @burger.save
  redirect to( "/burgers")
end

#read
get '/burgers/:id' do
  @burger = Burger.find(params['id'])
  @restaurant = @burger.find_restaurant
  @deals = Deal.all
  erb( :"burgers/show" )
 end

#update
get '/burgers/:id/edit' do
  @restaurants = Restaurant.all()
  @burger = Burger.find(params['id'])
  erb( :"burgers/edit" )
end

post '/burgers/:id' do
  @restaurants= Restaurant.all()
  @burger = Burger.new(params)
  @burger.update()
  redirect to ("/burgers")
end

#destroy
post '/burgers/:id/delete' do
  burger = Burger.find(params['id'])
  burger.delete()
  redirect to("/burgers")
end
