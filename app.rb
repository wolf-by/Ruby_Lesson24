#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

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

	hh2 = { :email => 'Введите email',
			:message => 'Введите сообщение'
	}

	hh2.each do |key, value|
		if params[key] == ''
			@error = hh2[key]
			return erb :contacts
		end	
	end	
	
	f = File.open './public/contacts.txt', 'a'
	f.write "Email клиент: #{@email}, Сообщение: #{@message}\n"
	f.close

	#отправка данных страницы contacts на почту 
	Pony.mail ({

	:to => '@gmail.com', #адрес куда отправить 
	:subject => 'Barber shop',
	:body => "Email клиент: #{@email}, Сообщение: #{@message}\n",
	:via => :smtp,
	:via_options => {
		:address => 'smtp.gmail.com',
		:port => '587',
		:user_name => '@gmail.com', #ваша почта на gmail, с нее отправка
		:password => '', #требуется в аккаунте gmail создать - Пароль приложений
		:authentication => :plain, 
		:domain => 'gmail.com'
	} 
})

	erb "Данные отправлены" 
end