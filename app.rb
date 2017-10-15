require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/applyingdeals_controller')
require_relative('controllers/burgers_controller')
require_relative('controllers/deals_controller')
require_relative('controllers/restaurants_controller')

# should it be called something else?
get '/' do
  erb( :index )
end
