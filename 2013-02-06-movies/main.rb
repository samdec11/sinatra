require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'httparty'
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/movie' do
  @title = params[:title]
  @title1 = params[:title].split
  @title2 = @title1.map do |x|
      x.capitalize
    end
  @title3 = @title2.join(" ")
  if @title.nil?
  else @title = @title.downcase.gsub(" ", "+")
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{@title}")
    @movie_hash = JSON(@movie)

  sql = "insert into movies (title, year, rated, released, runtime, genre, director, writer, actors, plot, poster) values ('#{@movie_hash['Title']}', '#{@movie_hash['Year']}', '#{@movie_hash['Rated']}', '#{@movie_hash['Released']}', '#{@movie_hash['Runtime']}', '#{@movie_hash['Genre']}', '#{@movie_hash['Director']}', '#{@movie_hash['Writer']}', '#{@movie_hash['Actors']}', '#{@movie_hash['Plot']}', '#{@movie_hash['Poster']}')"

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  conn.exec(sql)
  conn.close
  end
  erb :movie
end

get '/movies' do
  sql = 'select poster from movies'

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :posters
end

get '/about' do
  erb :about
end

get '/faq' do
  erb :faq
end

