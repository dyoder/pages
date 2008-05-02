module Application

  module Configurations
      
    class Default < Waves::Configurations::Default
      types = YAML.load( File.read( :configurations / 'mime_types.yml' ))
      mime_types.mapping.merge! types if types

  		log :level => :info, :output => "log/pages.log"	
      session :duration => 2.days, :path => :tmp / :sessions
  		reloadable [ Application ]

    end


  end
  
end
