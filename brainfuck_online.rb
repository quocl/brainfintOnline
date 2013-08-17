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
	src =	params[:bfSource]
	#begin
	#	time = Timeout::timeout(30){ 
	src
	interpreted_program = Brainfuck.new(src)
	interpreted_program.eval
	#	}
	#rescue
	#	puts "Something wrong happens..."
	#end
end



