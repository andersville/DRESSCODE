  class CupboardController < ApplicationController
  
  require 'mini_magick'

  def index
  
    @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item], true ])
    @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item], true ])
 
  
  end
  
  
  def add_clothes
  
    @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item], true ])
    @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item], true ])
 
  
  end

  def save_clothes
  
    @fabric = Fabric.new
    
    @fabric.name       = params['cloth_name']
    @fabric.size       = params['cloth_size']
    @fabric.user_id    = session[:user_item].id
    
    @fabric.save
    
    redirect_to(:controller => 'cupboard', :action => 'index')
    
    
    
    @clothes = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id ])
  
  
  end
  
  
  def look_for_clothes
  
     @clothes_all = Fabric.find(:all, :conditions => ["user_id = ?", session[:user_item].id])
     @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
     @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
    
  end
  
  
  def update_clothes
  
   
    if params['send'] == "Poista vaate"
    
      Fabric.delete(params[:cloth_id])
      
      else
      
      
      @cloth = Fabric.find_by_id(params[:cloth_id])
      
    
    
      unless params[:photo].nil?
    
        
        @photo = Photo.new(params[:photo])
        
        
        
        @thumbnail = Thumbnail.new
        @thumbnail.binary_data = ""
        @thumbnail.filename = "thumb.jpg"
         
         
        # write the file
        # 
        @photo.write_to_file("filename.jpg")
     
      
    
          
        # sent to minimagic
        # 
        @img_magick = MiniMagick::Image.open("filename.jpg")
        @img_magick.resize "150x150"
        @img_magick.write(@thumbnail.filename)
        
        
        # open thumb file to read and write 
        # it to binary_data 
        #
        File.open(@thumbnail.filename) do |file|
          while line = file.gets
              @thumbnail.binary_data += line
          end
        end
       
     
        
      # Save operation
      #
        @cloth.photo = @photo
        @cloth.photo.thumbnail = @thumbnail
     end
    
     
    
     @wear_flag    = nil
     @bugwear_flag = nil
    
     if params[:wear] == "on"
       @wear_flag = true
     else
        @wear_flag = false
     end
    
     if params[:fleawear] == "on"
       @bugwear_flag = true
     else
        @bugwear_flag = false
     end
    
     @cloth.weargear = @wear_flag
     @cloth.bugwear  = @bugwear_flag
   
     
    if @cloth.save
      #flash[:notice] = 'Photo was successfully created.'
      redirect_to :action => 'look_for_clothes'
    else
      render :action => 'profiles_menu'
    end
      
      
    end
     
      
    @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
    @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
   
  
  end


  def modify
  
    @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
    @cloth_item = Fabric.find_by_id(params[:id])
  
  end
  
  def view
  
    @clothes = Fabric.find(:all, :conditions => ["user_id = ? and weargear = ?", session[:user_item].id, true ])
    @flea_gear = Fabric.find(:all, :conditions => ["user_id = ? and bugwear = ?", session[:user_item].id, true ])
 
    @cloth_item = Fabric.find_by_id(params[:id])
  
  
  end
  
  
    def code_image

      @image_data = Photo.find(params[:id])
      @image = @image_data.binary_data
      
      #@thumbnail = Thumbnail.new
      #@thumbnail.binary_data = ""
      #@thumbnail.filename = "thumb.jpg"
     
     
      # write the file
      # 
      #@image_data.write_to_file("filename.jpg")
    
  
      
      # sent to minimagic
      # 
      #@img_magick = MiniMagick::Image.from_file("filename.jpg")
      #@img_magick.resize "130x130"
      #@img_magick.write(@thumbnail.filename)
    
    
      # open thumb file to read and write 
      # it to binary_data 
      #
      #File.open(@thumbnail.filename) do |file|
      #  while line = file.gets
      #      @thumbnail.binary_data += line
      #  end
      #end
      
      
      # save thumbnail
      # 
      #@image_data.thumbnail = @thumbnail
      #@image_data.save
      
    
     send_data(@image_data.binary_data,  :type => @image_data.content_type,
                              :filename => @image_data.filename,
                              :disposition => 'inline')


   end
   
   
   def code_thumbnail
  
  
     @image_data = Photo.find(params[:id])
     @image = @image_data.binary_data
  
     send_data(@image_data.thumbnail.binary_data,  :type => @image_data.content_type,
                              :filename => @image_data.filename,
                              :disposition => 'inline')

   end


end
