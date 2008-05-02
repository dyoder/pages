require 'RMagick'

class Image
	
	API = Magick::Image

  # width, height
  Dimensions = { :xlarge => [ 1200, 900 ], :large => [ 800, 600 ], :medium => [ 600, 400 ],
    :small => [ 300, 200 ], :xsmall => [ 200, 150 ], :thumb => [ 150,  100 ] }
	
	attr_reader :data

	def initialize( data = nil )
		@data = data
	end
	
	def Image.read( path )
		Image.new( ::File.read( path ) ) 
	end
	
	def resize!( size = nil )
		return self unless ( size && Array === size )
		width, height = *size
    image = API.from_blob( @data ).first rescue nil
		@data = image.resize_to_fit!(width,height).to_blob
		self
	end
		
	def to_blob
		@data
	end

end