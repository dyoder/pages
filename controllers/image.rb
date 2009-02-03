module Pages
  
  module Controllers
  
    class Image < Default
      
      def get( path )
				path = resolve( path )
				( params[:size] ? resize( path, params[:size] ) : ::Image.read( path ) ).to_blob
			end
			
			def delete( name )
				instance = find( name )
				clear_cache( instance )
				instance.delete
			end
			
			# TODO: Add file upload support to controller (or resource)
		  #functor( :file=, Hash ) do | file |
	    #   unless f[:filename].empty?
  		# 		set( 'content_type',f[:type])
  		# 		puts "FILENAME",f[:filename]
  		# 		fname = set('file',"#{name}#{File.extname(f[:filename])}")
  		# 		FileUtils.cp( f[:tempfile].path, db.storage.path( fname ).gsub('/image/','/file/') ) 
  		# 	end
		  #end
				
      
			
			private
						
			def resolve( path )
				unless File.extname( path ).empty?
					path = [ :db / domain / :file / path, :public / :images / path  ].find do | path |
					  File.exist?( path )
					end
					path or not_found
				else
				  image = app::Models[ model_name ][ domain ].find(path)
					response.content_type = image.attributes['file'][:type]
					image.filepath
				end
			end
						
			def resize( path, size )
			  dimensions = size.split('x').map { |d| d.to_i }
			  dimensions = ::Image::Dimensions[ size.intern ] if dimensions.length == 1
				unless image = cached( path, dimensions )
					image = ::Image.read( path ).resize!( dimensions )
					cache( path, dimensions, image )
				end
				response.expires = ( Date.today + 365 ).strftime('%a, %d %b %Y 00:00:00 GMT')
				image
			end
			
			def cached( path, size )
				path = cache_path( path, size )
				::Image.new( File.read( path ) ) if File.exist?( path )
			end
			
			def cache( path, size, image )
				File.write( cache_path( path, size ), image.to_blob )
			end

			def clear_cache( instance )
				Dir[ :db / domain / :cache / instance.file + '*' ].each do |path|
					FileUtils.remove( path )
			end
			end

			def key( path, size )
				[ File.basename( path ), 
					File.mtime( path ).strftime('%F-%H:%m:%S'), 
					size.join('x') ].join('.')
			end
			
			def cache_path( path, size )
				:db / domain / :cache / key( path, size )
			end
			
		end
	end
end