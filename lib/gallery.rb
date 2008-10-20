module Pages
  module Utilities
    
    # WARNING: this code has not been tested! It was extracted from an IRB session
    # and generalized. It needs to be tested.
    #
    # TODO: Need to add zip file support. Then we can do an upload gallery feature
    # using the file upload of the zip. See rubyzip on sourceforge.
    #
    
    module Gallery
      
      # options should include domain, path, title, and key
			def self.import( options )
        I = Pages::Models::Images[ options[ :domain ] ]
        G = Pages::Models::Gallery[ options[ :domain ] ]

        # first copy the files into the file directory
        Dir["#{path}/*"].each do |path| 
          src = options[ :path ]
          dst = :db / options[ :domain ] / :file / File.basename( options[ :path ] )
          FileUtils.cp( src, dst  )
        end

        # next, create all the images ...
        keys = Dir[ "#{ options[ :path ] }/*" ].map do |path| 
          type = path.match( /\.(\w+)$/ )
          key = File.basename( path, ".#{type}" )
          I.create( 'key' => key, 'file' => "#{key}.#{type}", 'content-type' => "image/#{type}" )
        end.map { |image| image.key }

        # finally, create the gallery
        G.create( 'key' => options[ :key ], 
          'title' => options[ :title ], 
          'display' => 'Album', 'images' => keys )			
			end
      
    end
    
  end
  
end