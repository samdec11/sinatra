require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'
require 'json'

get '/' do
  sql = "select * from tasks"

  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close

  erb :home
end

get '/about' do
  erb :about
end

get '/faq' do
  erb :faq
end

get '/new' do
  erb :new
end

post '/create' do
@post_date = params[:post_date]
@title = params[:title]
@description = params[:description]
sql = "insert into tasks (post_date, title, description) values ('#{@post_date}', '#{@title}', '#{@description}')"

  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  conn.exec(sql)
  conn.close

  redirect to ('/')

end