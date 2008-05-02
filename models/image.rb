module Application
	
	module Models 
		
		class Image < Application::Models::Default
			
			def file=( f )
			  case f
		    when String
		      set('file',f)
		    when Hash
		      unless f[:filename].empty?
    				set( 'content_type',f[:type])
    				puts "FILENAME",f[:filename]
    				fname = set('file',"#{name}#{File.extname(f[:filename])}")
    				FileUtils.cp( f[:tempfile].path, :db / domain / :file / fname ) 
    			end
  			end
			end

			def gallery=( name )
				unless gallery.nil? or gallery.empty?
					gallery = Models::Gallery.find( domain, name )
					unless gallery.entries.include?( self.name )
						gallery.entries << self.name
						gallery.save
					end
					set( :gallery, name )
				end
			end
				
		end
		
	end
	
end
