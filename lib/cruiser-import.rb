require 'extensions/all'
require 'fileutils'

def import(domains,types=[:story,:image,:document,:product,:catalog,:menu])
	
	domains.each do |domain|
		
		puts "Importing site #{domain} ..."
		
		puts "Looking up site ..."
		site = ZoneRecord.find_by_name(domain).site
		
		root = "/home/dan/db/#{domain}"
		
		puts "Creating storage directories (if necessary) ..."
		FileUtils.mkdir( root ) unless File.exist?( root )
		
		types.each do |dir|
			path = "#{root}/#{dir}"
			FileUtils.mkdir( path ) unless File.exist?( path )
		end
			
		elements = site.elements

		if types.include? :story
			puts "Importing stories ..."
			stories = elements.select { |el| el.model == 'story' }.
				map { |el| el.dereference }.compact
			stories.each do | story |
			
				puts "- #{story.name}"
			
				hash = {
					'name' => story.name,
					'title' => story.title,
					'author' => ( story.author.full_name if story.author ),
					'published' => story.created_on,
					'summary' => story.description,
					'content' => story.body,
					'format' => story.markdown ? 'textile' : 'wysiwyg'
				}
			
				File.write( "#{root}/story/#{story.name}.yml", hash.to_yaml )
			
			end
		end
		
		if types.include? :image
		
			puts "Importing images ..."
			images = elements.select { |el| el.model == 'image' }.
				map { |el| el.dereference }.compact
			images.each do |image|
			
				puts "- #{image.name}"
				hash = {
					'name' => image.name,
					'author' => ( image.author.full_name if image.author ),
					'published' => image.created_on,
					'content-type' => image.content_type,
					'file' => "#{image.name}#{image.extension}"
				}
			
				File.write( "#{root}/image/#{image.name}.yml", hash.to_yaml )
			
				puts "- locating image file ..."
				['xlarge','large','medium','small','xsmall'].find do |size|
					src = "public/site/#{site.id}/images/#{image.name}/#{size}#{image.extension}"
					dst = "#{root}/file/#{hash['file']}"
				 	if File.exist?(src) 
						puts "- copying image file #{size} ..."
						FileUtils.copy(src,dst); true
					end
				end
			
			end
		end
		
		if types.include? :document

			puts "Importing documents ..."
			docs = elements.select { |el| el.model == 'document' }.
				map { |el| el.dereference }.compact
			docs.each do |doc|
			
				puts "- #{doc.name}"
				hash = {
					'name' => doc.name,
					'author' => ( doc.author.full_name if doc.author ),
					'published' => doc.created_on,
					'content-type' => doc.content_type,
					'file' => "#{doc.name}#{doc.extension}"
				}
			
				File.write( "#{root}/media/#{doc.name}.yml", hash.to_yaml )

				src = "public/site/#{site.id}/docs/#{hash['file']}"
				dst = "#{root}/file/#{hash['file']}"

				puts "- copying document file ..."
			 	FileUtils.copy(src,dst) if File.exist?(src)
			
			end
		end
		
		if types.include? :menu
		end
		
		if types.include? :product
			puts "Importing products ..."
			products = elements.select { |el| el.model == 'product' }.
				map { |el| el.dereference }.compact
			products.each do | product |
			
				puts "- #{product.name}"
			
				hash = {
					'name' => product.name,
					'title' => product.title,
					'author' => ( product.author.full_name if product.author ),
					'published' => product.created_on,
					'description' => product.description,
					'format' => 'textile',
					'summary' => product.summary,
					'image' => ( product.image.name if product.image ),
					'shipping' => product.regular_shipping,
					'price' => product.price_cents,
					'taxable' => product.taxable
				}
			
				File.write( "#{root}/product/#{product.name}.yml", hash.to_yaml )
			end
			
		end
		
		if types.include? :catalog
			
			puts "Importing catalogs ..."
			# for some reason, starting with the site elements doesn't work here ...
			catalogs = Catalog.find(:all).select { |c| c.site.id == site.id }
			catalogs.each do | catalog |
				puts "- #{catalog.name}"
			
				hash = {
					'name' => catalog.name,
					'title' => catalog.title,
					'author' => ( catalog.author.full_name if catalog.author ),
					'published' => catalog.created_on,
					'summary' => catalog.description,
					'products' => catalog.products.map { |p| p.name }
				}

				File.write( "#{root}/catalog/#{catalog.name}.yml", hash.to_yaml )
			end

		end
		
		puts "Import complete."
		
	end
end
		
		
		