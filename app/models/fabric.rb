class Fabric < ActiveRecord::Base
 
  belongs_to :user and :note_item
  has_one :photo
 
end
