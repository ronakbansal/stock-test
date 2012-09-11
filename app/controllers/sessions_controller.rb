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
    redirect_to root_url
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
#@symbol_alt = YahooStock::ScripSymbol.new(@search_term+".BO")
@results = @symbol.results(:to_hash).output
#@results_alt = @symbol_alt.results(:to_hash).output

#@quote = YahooStock::Quote.new(:stock_symbols => ["MOTILALFS.BO", "TAKMCHN.BO","TCSFL.BO","TCS.NS","TCSQF.BO","TCS.BO","BHARTIARTL.BO"])
end
def add_to_portfolio
@add_to_table = Portfolio.create(:user_id => current_user.id, :script_symbol => params[:script_symbol], :quantity => params[:quantity], :user_price => params[:user_price],:buyorsale => params[:buyorsale])
#@port = Portfolio.find_by_user_id(:all,current_user.id)
render :nothing => true


end
def my_portfolio
@my_scripts = Portfolio.find(:all, :conditions => [ "user_id = ?", current_user.id])
end
end
