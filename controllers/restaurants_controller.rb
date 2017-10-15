require ( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/restaurant.rb' )
require_relative( '../models/burger.rb')
require_relative( '../models/deal.rb')
require_relative( '../models/applyingdeal.rb')


get '/restaurants' do
  @restaurants = Restaurant.all
  @burgers = Burger.all
  @deals = Deal.all
  @applyingdeals = ApplyingDeal.all
  erb ( :"restaurants/index" )
end

#create

get '/restaurants/new' do
  erb( :"restaurants/new" )
end

post '/restaurants' do
  @restaurant = Restaurant.new(params)
  @restaurant.save()
  erb( :"restaurants/show")
end

#read

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params['id'])
  @burgers = Burger.all()
erb( :"restaurants/show" )
end

#update
get '/restaurants/:id/edit' do
  @restaurant = Restaurant.find(params['id'])
  erb( :"restaurants/edit" )
end

post '/restaurants/:id' do
  @restaurant = Restaurant.new(params)
  @restaurant.update()
  redirect to( "/restaurants")
end

#delete
post '/restaurants/:id/delete' do
  restaurant = Restaurant.find(params['id'])
  restaurant.delete()
  erb( :"restaurants/delete" )
end
