class NoteItem < ActiveRecord::Base

  belongs_to  :note
  has_many    :fabric

end
