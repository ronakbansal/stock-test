class SessionsController < ApplicationController
 require 'rubygems'
require 'yahoo_stock'

def new
end

def create
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
	welcome
    
  else
    flash.now.alert = "Invalid email or password"
    render "welcome"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end

def welcome
  render "welcome"
end

def search
#@stock = StockQuote::Stock.quote("BSE:tcs")
@search_term = params[:search]
@symbol = YahooStock::ScripSymbol.new(@search_term)
@symbol_alt = YahooStock::ScripSymbol.new(@search_term+".BO")
@results = @symbol.results(:to_hash).output
@results_alt = @symbol_alt.results(:to_hash).output
a = current_user.id
p "------------------"
p a
#@quote = YahooStock::Quote.new(:stock_symbols => ["MOTILALFS.BO", "TAKMCHN.BO","TCSFL.BO","TCS.NS","TCSQF.BO","TCS.BO"])
end
end
