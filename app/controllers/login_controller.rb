class LoginController < ApplicationController

 # model   :user
 # layout  'scaffold'
 # 



  def login
    
     case request.method
      when :post
        if session[:user_item] = User.authenticate(params['user_login'], params['user_password'])

          flash['notice']  = "Login successful"

         redirect_to(:controller => 'mainpage', :action => 'index')

          else
           login    = params['user_login']
           @message  = "Login unsuccessful, checkout if capslock is on... need to sign up ??<br>"

      end
    end
  end


  def signup
    case request.method
      when :post
        user = User.new(params['user'])
        user.visits = 0;
        #@user.profile = Profile.new
        #@user.profile.photo = Photo.new
        
        if user.save
          
          
          session[:user_item] = User.authenticate(user.username, params['user']['password'])
          
          #@session[:person] =  User.new(@params['user'])
          redirect_to :controller => "mainpage" , :action => "index"
        end
      when :get
        user = User.new
    end
  end



  # TO DO
  # 
  def delete
    if @params['id']
      @user = User.find(@params['id'])
      @user.destroy
    end
    redirect_to :action => "welcome"
  end

  def logout

     if session[:user_item]
       @user = User.find(session[:user_item].id)
       #@user.update_attribute( :logged, 'false' )
       session[:user_item] = nil
     end
      
      #ls
      #session[:current_user_id] = nil
      #reset_session
      redirect_to :controller => "login", :action => "login"
      
    
  end


  # OPTIONAL>> TODO
  #
  def welcome
          @username = @params['user_login']
          redirect_to :controller => "mainpage", :action => "mainpage"

  end
  
  

  
  
 

end

