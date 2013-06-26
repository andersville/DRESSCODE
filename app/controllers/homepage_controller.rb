class HomepageController < ApplicationController

  def index
  
  @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
  @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
  
  end


  def send_message
  
  @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
  @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
  
  
  @users = User.find(:all, :conditions => ["id != ? ", session[:user_item].id])
  
  
  end
  
  
  def messages
  
  @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
  @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
  
  @messages = Message.find(:all, :conditions => ["receiver_id = ?", session[:user_item].id])
  
  
  end


 def save_message
  
  @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
  @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
  
    
  @msg = Message.new
  @msg.message_text = params['message']
  @msg.sender_id = session[:user_item].id
  @msg.receiver_id = params['receiver']
  @msg.save

  
  
  redirect_to(:controller => 'homepage', :action => 'messages') 
  
  @messages = Message.find(:all, :conditions => ["receiver_id = ?", session[:user_item].id])
  
  
  end




end
