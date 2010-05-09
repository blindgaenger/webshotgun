require 'ftools'

class Page < ActiveRecord::Base
  after_create :refresh

  validates_presence_of :name
  validates_presence_of :url
  
  IMAGE_SIZE = 200.freeze
  TEMP_DIR = "/tmp".freeze

  def refresh
    Delayed::Job.enqueue self
  end

  def perform
    basename = self.name.parameterize.to_s
    filename = File.join(TEMP_DIR, "#{basename}-#{Time.now.to_i}")

    system "webkit2png #{url} --filename=#{filename} --clipwidth=#{IMAGE_SIZE} --clipheight=#{IMAGE_SIZE} --clipped --scale 0.2"
    
    image_filename = "#{filename}-clipped.png"
    self.image = File.read(image_filename)
    self.save!
    File.delete(image_filename)
    
    self.touch # for cache control
  end
  
end
