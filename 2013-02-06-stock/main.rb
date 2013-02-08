require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'
require 'active_support/all'

get '/stock' do
  @symbol = params[:symbol]
  if @symbol.nil?
  else
    @symbol = @symbol.upcase
    @result = YahooFinance::get_quotes(YahooFinance::StandardQuote, @symbol)[@symbol].lastTrade
  end
  erb :stock
end