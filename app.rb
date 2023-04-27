#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School - Labs 24</a>"			
end

get '/about' do 
	erb :about
end

get '/contacts' do 
	erb :contacts
end

get '/visit' do
	erb :visit
end

post '/visit' do 
	@username = params[:username]
	@phone = params[:phone]
	@master = params[:value]
	@datetime = params[:datetime]
 	@color = params[:color]

 	hh = { :username => 'Введите имя',
 		   :phone => 'Введите телефон',
 		   :datetime => 'Введите дату и время'
 	}

 	hh.each do |key, value|
 		if params[key] == ''
 		@error = hh[key]
 		return erb :visit
 		end
 	end	




	f = File.open './public/users.txt', 'a'
	f.write "Клиент: #{@username}, Телефон: #{@phone}, Парикмахер: #{@master}, Дата и время: #{@datetime}, Цвет краски: #{@color}.\n"
	f.close

	erb :visit
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]
	
	f = File.open './public/contacts.txt', 'a'
	f.write "Email клиент: #{@email}, Сообщение: #{@message}\n"
	f.close

	erb :contacts
end