module Pages
  module Controllers
    class Media < Default
      
      def get( media, name )
  		  data = [ :public / media / name, 
  		            :db / domain / :file / name, 
  		            :db / domain / :theme / name ].each do |path|
          return File.read( path ) if File.exist?( path )
        end
        not_found
      end

    end
  end
end
