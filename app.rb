#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'



# подключение к БД
set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
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
	@c = Client.new
	erb :visit
end

post '/visit' do
	
	@c = Client.new params[:client]

	if @c.save
		erb "Thanks"
	else
		@error = @c.errors.full_messages.first
		#@error = 'Введите все данные'
		erb :visit
	end
	#@error = c.errors.messages.values.join(',')
end

get '/barber/:id' do

	erb :barber
	
end
