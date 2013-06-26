require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base

  #has_and_belongs_to_many :roles
  has_many :friendships
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :fabric
  has_many :message
 
 

  def self.authenticate(username, pass)
    @user =  find(:first, :conditions => ["username= ? AND password = ?", username, sha1(pass)])
 
     if @user.nil?

       return nil

     else

       return @user

     end 

 end


  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end
  
  
  protected 
  
  def self.sha1(pass)
    Digest::SHA1.hexdigest("Voterun_juoksuttaa_kunnolla#{pass}--")
  end
  
  def self.sha_admin(pass)
    Digest::SHA1.hexdigest("Ja_painit_kaupanpaalle#{pass}--")
  end

  before_create :crypt_password

  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end
 
   


  validates_length_of :username, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_length_of :email, :within => 1..40
  validates_presence_of :username, :password, :password_confirmation
  validates_uniqueness_of :username, :on => :create
  validates_confirmation_of :password, :on => :create
end


