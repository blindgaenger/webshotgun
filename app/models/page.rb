require 'ftools'

class Page < ActiveRecord::Base
  after_create :refresh

  validates_presence_of :name
  validates_presence_of :url
  
  def refresh
    Delayed::Job.enqueue self
  end

  def perform
    self.update_attribute :image, webshot(self.name, self.url)
    self.touch # for cache control and polling
  end

private

  IMAGE_SIZE = 200.freeze
  TEMP_DIR = "/tmp".freeze

  def webshot(name, url)
    basename = name.parameterize.to_s
    filename = File.join(TEMP_DIR, "#{basename}-#{Time.now.to_i}")

    system "webkit2png #{url} --filename=#{filename} --clipwidth=#{IMAGE_SIZE} --clipheight=#{IMAGE_SIZE} --clipped --scale 0.2"
    
    image_filename = "#{filename}-clipped.png"
    data = File.read(image_filename)
    File.delete(image_filename)
    data
  end

end
