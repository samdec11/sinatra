require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/calc' do
  @first = params[:first].to_f
  @second = params[:second].to_f

  @result = case params[:operator]
  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then @first * @second
  when '/' then @first / @second
  end

  erb :calc
end

# get '/calc/multiply/:first/:second' do
#   @result = params[:first].to_f * params[:second].to_f
#   erb :calc
# end

# get '/calc/add/:first/:second' do
#   @result = params[:first].to_f + params[:second].to_f
#   erb :calc
# end

# # ------------------------------------------#
# get '/name/:first/:last/:age' do
#   "your name is : #{params[:first]} #{params[:last]} and you are #{params[:age]} years old."
# end

# get '/hello' do
#   'i am a master hacker ninja!!!'
# end

# get '/' do
#   'this is the home page'
# end

# get '/sean' do
#   'Hello, Sean Marzug-McCarthy!'
# end