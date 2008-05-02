module Application
  
  module Controllers
    
    
    class Media < Application::Controllers::Default
      
      def resource( media, name )
  		  data = [ :public / media / name, 
  		            :db / domain / :file / name, 
  		            :db / domain / :theme / name ].each do |path|
          return File.read( path ) if File.exists?( path )
        end
        not_found
      end

    end
    
  end
  
end
      