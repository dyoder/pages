require 'filebase/drivers/yaml'
Filebase.storage = Filebase::Drivers::YAML
module Pages

  module Models

    class Default

      include Pages::ResponseMixin

      def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )
        end
      end

      def self.associate( domain ) ; end


      def title ; get( :title ) or '' ; end

      def readable_key
        return get( :key ).to_s.gsub(/\b\w/){$&.upcase}.gsub('-',' ')
      end

      # we have to support old formats.
      def published
        rval = get( :published )
        return Date.parse(rval.strftime('%Y/%m/%d')) if rval.is_a? Time
        return Date.parse(rval) if rval.is_a? String
        return rval if rval.is_a? Date
        return Date.today
      end

      def name ; get( :key ) ; end

    end

  end

end

