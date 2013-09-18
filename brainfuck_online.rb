require 'sinatra'
require 'timeout'
require 'haml'
require './helpers/brainfuck'

['/', '/home'].each do |home|
	get "#{home}" do
		haml :index
	end
end

post '/interpret' do
	interpreted_program = Brainfuck.new(params[:bfSource])
	@output = interpreted_program.eval(params[:bfInput])
	haml :interpret
end

