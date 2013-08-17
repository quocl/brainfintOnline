require 'sinatra'
require 'timeout'
require './helpers/brainfuck'

['/', '/home'].each do |home|
	get "#{home}" do
		"Hello this is brainfuck interpreter"		
		erb :index
	end
end

post '/secret' do
	interpreted_program = Brainfuck.new(params[:bfSource])
	out = interpreted_program.eval
	out
	#	}
	#rescue
	#	puts "Something wrong happens..."
	#end
end



