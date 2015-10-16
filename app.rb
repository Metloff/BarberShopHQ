require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# подключение к БД
set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.order 'created_at DESC'
end

get '/' do
	@barbers = Barber.order 'created_at DESC'
	erb :index 
end

get '/visit' do
	erb :visit
end

post '/visit' do
	
	c = Client.new params[:client]
	c.save
end
