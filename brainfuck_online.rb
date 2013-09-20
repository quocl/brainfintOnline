require 'sinatra'
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'sinatra/base'
require './helpers/brainfuck'

class BrainfuckOnline < Sinatra::Base
	register Sinatra::Twitter::Bootstrap::Assets

	use Rack::CommonLogger

	enable :inline_templates

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
end

BrainfuckOnline.run!
