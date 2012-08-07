require './game.rb'

map "/" do
	use Rack::Session::Cookie	
	run Game.new	
end