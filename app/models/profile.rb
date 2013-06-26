class Profile < ActiveRecord::Base
 
   belongs_to :user
  # has_one :profile_pic, :class_name => 'photo', :foreign_key =>'photo_id'
   has_one :photo

end
