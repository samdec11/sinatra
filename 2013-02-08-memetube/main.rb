require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

before do
  sql = "select distinct genre from videos order by genre"
  @nav_rows = run_sql(sql)
end

get '/' do
  sql = "select * from videos order by title"
  @rows = run_sql(sql)
  erb :home
end

get '/new' do
  erb :new
end

get '/:id/edit' do
  sql = "select * from videos where id = #{params['id']}"
  rows = run_sql(sql)
  @row = rows.first
  erb :new
end

post '/create' do
  sql = "insert into videos (title, description, url, genre) values ('#{params['title']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
  run_sql(sql)
  redirect to('/')
end

post '/:id' do
  sql = "update videos set title='#{params['title']}', description='#{params['description']}', url='#{params['url']}', genre='#{params['genre']}' where id = #{params['id']}"
  run_sql(sql)
  redirect to('/')
end

post '/:id/delete' do
  sql = "delete from videos where id = #{params['id']}"
  run_sql(sql)
  redirect to('/')
end

get '/:genre' do
  sql = "select * from videos where genre = '#{params['genre']}'"
  @rows = run_sql(sql)
  erb :home
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'memetube', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end