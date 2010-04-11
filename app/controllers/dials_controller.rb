require 'ftools'

class DialsController < ApplicationController
  LINKS = {
    'Google' => 'http://www.google.de/',
    'Yahoo' => 'http://www.yahoo.de/',
    'Avocado Store' => 'http://www.avocadostore.de/',
    'blindgaenger' => 'http://blindgaenger.net/'
  }
  IMAGE_SIZE = 200.freeze
  IMAGE_PATH = "/system/dials"
  
  def index
    @pages = LINKS.map do |name, url| 
      image = create_webshot(name, url)
      [name, url, image]
    end
  end

private

  def create_webshot(name, url)
    basename = name.parameterize.to_s
    filename = "#{basename}.png"
    Dir.chdir("public#{IMAGE_PATH}") do
      unless File.exist?(filename)
        system "webkit2png #{url} --filename=#{basename} --clipwidth=#{IMAGE_SIZE} --clipheight=#{IMAGE_SIZE} --clipped --scale 0.2"
        File.mv "#{basename}-clipped.png", filename
      end
    end
    File.join IMAGE_PATH, filename
  end
  
end
