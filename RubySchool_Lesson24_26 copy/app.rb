#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	return SQLite3::Database.new 'barbershop.db'
end

configure do
	@db = get_db
	@db.execute <<-SQL
		CREATE TABLE IF NOT EXISTS Users (
			Id INTEGER PRIMARY KEY AUTOINCREMENT,
			Name TEXT,
     	Datastamp TEXT,
	   	Barber TEXT,
	   	Colour TEXT
		)
 SQL
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!!!!!!!!"
end

get '/about' do

	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@time = params[:time]
	@phone = params[:phone]
	@barber = params[:barber]
	@color = params[:color]

	hh = {:username => "Введите имя", :time => "Віберітє врємя", :phone => "Введите ваш номер телефона"}
		@error = hh.select {|key,_| params[key] ==""}.values.join(",")
		if @error != ''
			return erb :visit
		end

	db =	get_db
			db.execute 'insert into Users (
			name,
			phone,
			datastamp,
			barber,
			colour
			)
	values (?,?,?,?,?)', [@username, @phone, @time, @barber, @colour]



	erb "OK, #{@username}, будем ждать Вас в #{@time} у #{@barber}, если что, наберем по телефону #{@phone}. Будемкрасить вас в #{@color}. До встречи!!"
end


post '/contacts' do
	@email = params[:email]
end
