class MainpageController < ApplicationController

 
  def index
  
  @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item], true ])
  @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item], true ])
  
  
  end

end
