module Pages
	
	module Models 
		
		class Image < Default
		  
		  include Functor::Method
		  
		  def associate( domain )
  		  has_one :gallery, :class => Pages::Models::Gallery[ domain ]
  		end
			
      # TODO: This belongs in the controller!
			functor( :file=, Hash ) do | file |
	      unless f[:filename].empty?
  				set( 'content_type',f[:type])
  				puts "FILENAME",f[:filename]
  				fname = set('file',"#{name}#{File.extname(f[:filename])}")
  				FileUtils.cp( f[:tempfile].path, db.storage.path( fname ).gsub('/image/','/file/') ) 
  			end
			end
				
		end
		
	end
	
end
