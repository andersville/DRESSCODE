 
class Photo < ActiveRecord::Base
 
  belongs_to :fabric
  has_one    :thumbnail

  validates_format_of  :content_type, :with => /^image/, :message => "you can only upload pictures"
 

  
  def image_file=(input_data)
    self.filename = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = input_data.read
  end
  

  
  def write_to_file(filename)
   
    File.new(filename, "w")
    file1 = File.open(filename, "w")
    old = $defout
    tmp = $stdout
    $stdout = file1
    
    puts self.binary_data
    $stdout = tmp
    file1.close
  
  end
  
  # REDO
  # 
  def read_from_file(img_file)
 
    File.open(img_file) do |file|
          while line = file.gets
              self.binary_data += line
          end
        end
  end
  


end
