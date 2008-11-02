require 'foundations/classic'
require 'layers/renderers/markaby'
require 'lib/image'
require 'lib/response_mixin'
module Pages
	include Waves::Foundations::Classic
	include Waves::Renderers::Markaby
end