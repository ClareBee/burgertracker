require ( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/deal.rb' )
require_relative( '../models/restaurant.rb' )
require_relative( '../models/burger.rb')
require_relative( '../models/applyingdeal.rb')



get '/deals' do
  @deals = Deal.all()
  @restaurants = Restaurant.all()
  @burgers = Burger.all()
  @applyingdeals = ApplyingDeal.all()
  erb ( :"deals/index" )
end

get '/deals/new' do
  @restaurants = Restaurant.all()
  erb ( :"deals/new" )
end

post '/deals' do
  deal = Deal.new(params)
  deal.save
  redirect to("/deals")
end

post '/deals/:id/delete' do
  deal = Deal.find(params['id'])
  deal.delete()
  redirect to("/deals")
end
