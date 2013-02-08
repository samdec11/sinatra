require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/friends' do
  sql = "select * from friends"
  @rows = run_sql(sql)
  erb :friends
end

get '/new_friend' do
  erb :new_friend
end

post '/create' do
  @name = params[:name]
  @age = params[:age]
  @gender = params[:gender]
  @image = params[:image]
  @twitter = params[:twitter]
  @facebook = params[:facebook]
  sql = "insert into friends (name, age, gender, image, twitter, facebook) values ('#{@name}', '#{@age}', '#{@gender}', '#{@image}', '#{@twitter}', '#{@facebook}')"
  run_sql(sql)
  redirect to ('/friends')
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'friend_app', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end