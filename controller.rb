require 'sinatra'
require './database.rb'


get '/' do
	redirect to '/students'
end

get '/students' do
	db = DBHandler.new 
	@students = db.all 
	@gradstud = db.allgrad
	@nongrad = db.allnongrad
	erb :application do #the general feel
		erb :index #shows the records from the database
	end
end

get '/students/new' do
	erb :application do
		erb :new
	end
end

post '/students' do
	db = DBHandler.new
	db.create(params[:firstname], params[:lastname] , params[:major] , params[:email] , params[:graduationstat])
	redirect to '/students'
	#store in db
end


get '/students/:id' do 
	db = DBHandler.new
	@student = db.get(params[:id].to_i)
	erb :application do
		erb :show
	end
end

post '/students/:id' do
	db = DBHandler.new
	db.update(params[:id].to_i, params[:firstname], params[:lastname], params[:major] , params[:email] , params[:graduationstat])
	redirect to '/students'
end

get '/students/:id/edit' do
	db = DBHandler.new
	@students = db.get(params[:id].to_i)
	erb :application do
		erb :edit
	end
end

get '/students/:id/delete' do
	db =DBHandler.new
	db.destroy(params[:id].to_i)
	redirect to '/students'
end
