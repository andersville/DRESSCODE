class WebshopController < ApplicationController

  def index
  
   @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
   @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
   @cloth_item = Fabric.find_by_id(params[:id])
  
 
   @sale_shirts = Fabric.find(:all, :conditions => ["bugwear = ? and user_id != ?", true, session[:user_item].id])
  
  
  end

  
  
  def check_fleawear
  
   @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
   @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
   @cloth_item = Fabric.find_by_id(params[:id])
   
   @stock_biddings = StockItem.find(:all, :conditions => ["fabrics_id = ?", @cloth_item.id])
  
 
   @sale_shirts = Fabric.find(:all, :conditions => ["bugwear = ?", true])
  
  
  end
  
  
  def bid_fleawear
  
  require 'bigdecimal'
  require 'bigdecimal/util'
  
  
   @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
   @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
   @cloth_item = Fabric.find_by_id(params[:id])
   
   
   @stock_biddings = StockItem.find(:all, :conditions => ["fabrics_id = ?", @cloth_item.id])
   
   @highest_stock_bidding = StockItem.find(:first, :conditions => ["fabrics_id = ?", @cloth_item.id], :order => ["cash desc"])
   
   if @highest_stock_bidding.nil?
   
      @highest_stock_bidding = StockItem.new
      @highest_stock_bidding.cash = 0
   
   end
  
 
   @sale_shirts = Fabric.find(:all, :conditions => ["bugwear = ?", true])
  
  
   end
   
   
   
   def save_fleawear_bid
  
     @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
     @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
   
     @cloth_item = Fabric.find_by_id(params['cloth_id'])
    
   
     @sale_shirts = Fabric.find(:all, :conditions => ["bugwear = ?", true])
     
     
     
     @stock_bidding     = StockItem.find(:first, :conditions => ["fabrics_id = ?", @cloth_item.id], :order => ["cash desc"])
    
     
     
     @stock_item = StockItem.new
     @stock_item.bidder_id = session[:user_item].id
     @stock_item.fabrics_id = params['cloth_id']
     @stock_item.cash = params['bid_amount']
   
 
     if @stock_bidding.nil?
     
       @msg = "Ostotarjous tallennettu" 
       @stock_item.save
       
      else if BigDecimal.new(params['bid_amount']) > @stock_bidding.cash
      
       @msg = "Ostotarjous tallennettu" 
       @stock_item.save
     
      else
     
        @msg_sum_above = "Tarjottu summa on pienempi kuin viimeksi annettu tarjous, muuta summaa"
     
        @msg2 = @stock_bidding.cash
    
      end
    
      end

      @stock_bidding_all = StockItem.find(:all, :conditions => ["fabrics_id = ?", @cloth_item.id], :order => ["cash asc"])
    
    
   end
   




end
