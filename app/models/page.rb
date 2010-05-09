require 'ftools'

class Page < ActiveRecord::Base
  after_create :refresh

  validates_presence_of :name
  validates_presence_of :url
  
  IMAGE_SIZE = 200.freeze
  IMAGE_PATH = "/system/pages".freeze

  def refresh
    Delayed::Job.enqueue self
  end

  def perform
    puts "BEFORE #{self.updated_at}"
    
    basename = name.parameterize.to_s
    filename = "#{basename}.png"
    Dir.chdir("public#{IMAGE_PATH}") do
      system "webkit2png #{url} --filename=#{basename} --clipwidth=#{IMAGE_SIZE} --clipheight=#{IMAGE_SIZE} --clipped --scale 0.2"
      File.delete(filename) if File.exist?(filename)
      File.mv "#{basename}-clipped.png", filename
    end

    new_filename = File.join(IMAGE_PATH, filename)
    if self.image && self.image != new_filename && File.exist?("public#{self.image}")
      File.delete("public#{self.image}")
    end
    self.update_attribute :image, new_filename
    self.touch
    
    puts "AFTER #{self.updated_at}"
  end
  
end
