module Pages
  module Configurations
    class Default < Waves::Configurations::Default
            
      resources do
        
        direct :accept => :image, :to => :image
        direct :accept => [ :css, :javascript ], :to => :media
        direct :accept => :rss, :to => :blog
        
        direct [ 'admin', :resource, { :rest => true }], :through => :admin
        direct [ 'admin' ], :to => :site, :through => :admin
        
        direct [ :resource, { :rest => true }]
        direct :story
        
      end
      
    end
  end
end