require 'waves/foundations/classic'
require 'waves/layers/orm/providers/filebase'
require 'lib/image'
require 'lib/response_mixin'
require 'waves/layers/renderers/markaby'
module Pages
	include Waves::Foundations::Classic
	include Waves::Renderers::Markaby
end
