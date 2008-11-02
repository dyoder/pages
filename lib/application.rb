require 'foundations/classic'
require 'layers/orm/providers/filebase'
require 'lib/image'
require 'lib/response_mixin'
require 'layers/renderers/markaby'
module Pages
	include Waves::Foundations::Classic
	include Waves::Renderers::Markaby
end
