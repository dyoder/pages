module Pages
  module Controllers
    class Media < Default
      
      def get( media, name )
        d = domain.sub(/^www\./,'')
  		  data = [ :public / media / name, 
  		            :db / d / :file / name, 
  		            :db / d / :theme / name ].each do |path|
          return File.read( path ) if File.exists?( path )
        end
        not_found
      end

    end
  end
end
