require 'ftools'

class Page < ActiveRecord::Base
  after_create :fetch

  validates_presence_of :name
  validates_presence_of :url
  
  IMAGE_SIZE = 200.freeze
  IMAGE_PATH = "/system/pages"

  def fetch
    return if self.image && File.exist?(self.image)
    
    basename = name.parameterize.to_s
    filename = "#{basename}.png"
    Dir.chdir("public#{IMAGE_PATH}") do
      unless File.exist?(filename)
        system "webkit2png #{url} --filename=#{basename} --clipwidth=#{IMAGE_SIZE} --clipheight=#{IMAGE_SIZE} --clipped --scale 0.2"
        File.mv "#{basename}-clipped.png", filename
      end
    end
    self.image = File.join(IMAGE_PATH, filename)
    save!
  end
  
end
