class HolidayController < ApplicationController

  def index
  
  
    @clothes_all     = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id])
    @clothes         = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear       = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
   
  end

 def make_holidaycup
  
  
    @clothes_all     = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item]])
    @clothes         = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear       = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
   
  end
  
  
  def holidaycup
 
    @clothes_all   = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id])
    @clothes       = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear     = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
    session[:note_name] = params[:name]
  
  end
  
  
  def save_holidaycup
  
    @clothes_all   = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item]])
    @clothes       = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item], true ])
    @flea_gear     = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item], true ])
    
    @note          = Note.new
    @note.name     = session[:note_name]
    @note.user_id  = session[:user_item].id
    @note.save
    
    for @items in params[:clothes]

    @note_item            = NoteItem.new
    @note_item.fabric_id  = @items
    @note_item.note_id    = @note.id 
    @note_item.save


    end    
    
  
  end
  
  
  def view_holidaycup
  
    @clothes_all   = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id])
    @clothes       = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear     = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
    @notes = Note.find(:all,  :conditions => ["user_id = ?", session[:user_item].id])
  
  end



  def look_holidaycup
  
    @clothes_all   = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id])
    @clothes       = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear     = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
  
    @notes = Note.find(:all,  :conditions => ["id = ?", params[:id]])
    @note_items = NoteItem.find(:all, :conditions => ["note_id = ?", params[:id]]) 
         
  
  end
  
  
  def generate_pdf_document
     
     require 'prawn'

    Prawn::Document.generate("prawn2.pdf") do
       text "Hello world!"
    end						
     
     
  end  

end
