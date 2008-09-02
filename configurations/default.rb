module Pages
  module Configurations
    class Development < Default
      
      resources [
        { :accepts => :image } => :image,
        { :accepts => [ :css, :js ] } => :media,
        { :accepts => :rss } => :blog,

        [ :resource, { :rest => true } ] => :visitor,
        [ :name ] => :story,

        [ 'admin', :resource, { :rest => true }] => :author,
        [ 'admin', { :rest => true } ] => :site
      ]      
      
    end
  end
end