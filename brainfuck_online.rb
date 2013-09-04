require 'sinatra'
require 'timeout'
require 'slim'
require './helpers/brainfuck'

['/', '/home'].each do |home|
	get "#{home}" do
		slim :index
	end
end

post '/interpret' do
	interpreted_program = Brainfuck.new(params[:bfSource])
	@output = interpreted_program.eval
	slim :interpret
end

