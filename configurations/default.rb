module Pages
  module Configurations
    class Default < Waves::Configurations::Default
            
      resources do
        
        mount :image, :accept => :image
        mount :media, :accept => [ :css, :javascript ]
        mount :blog, :accept => :rss
        
        mount true, [ 'admin', :resource, { :rest => true }], :as => :author
        mount :site, [ 'admin' ], :as => :author
        
        mount true, [ :resource, { :rest => true }], :as => :visitor
        mount :story, :as => :visitor
        
        
      end
      
    end
  end
end