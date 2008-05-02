namespace :server do 

  namespace :put do
    
    desc "Upload changes to pages codebase to the server."
    task :code do
      options = '-az --delete'
      excludes = ( [ :tmp, :db, :log, :icons ].map { |dir| "--exclude=#{dir}" }.join(' ') )
      from = './'
      to = 'dan@zeraweb.com:projects/pages'
      `rsync #{options} #{excludes} #{from} #{to}`
    end
  
    desc "Upload content changes, for one site or all sites, to the server."
    task :content do
      options = '-az --delete'
      excludes = ( [ :cache ].map { |dir| "--exclude=#{dir}" }.join(' ') )
      from = ENV['site'] ? "db/#{ENV['site']}/" : 'db/'
      to = 'dan@zeraweb.com:projects/pages/' + from
      `rsync #{options} #{excludes} #{from} #{to}`
    end
  
    desc "Upload changes to site theme or all themes to server."
    task :theme do
      options = '-az --delete'
      excludes = ( [].map { |dir| "--exclude=#{dir}" }.join(' ') )
      from = "db/#{ENV['site']}/theme/"
      to = 'dan@zeraweb.com:projects/pages/' + from
      `rsync #{options} #{excludes} #{from} #{to}`
      Application::Models::Story.all(ENV['site']).each do |story|
        if story.format == 'mab' 
          options = '-az'
          from = "db/#{ENV['site']}/story/#{story.name}.yml"
          to = 'dan@zeraweb.com:projects/pages/' + from
          `rsync #{options} #{from} #{to}`
        end
      end
    end
  
  end
  
  namespace :get do
    
    desc "Download content changes, for one site or all sites, from the server."
    task :content do
      options = '-az --delete'
      excludes = ( [ :cache ].map { |dir| "--exclude=#{dir}" }.join(' ') )
      to = ENV['site'] ? "db/#{ENV['site']}/" : 'db/'
      from = 'dan@zeraweb.com:projects/pages/' + to
      `rsync #{options} #{excludes} #{from} #{to}`
    end
  
    
  end

end

# task :data_sync do 
# 	puts "Data sync ..."
# 	if site = ENV['site']
# 		puts "Sync site #{site} ..."
# 		sh "rsync -avz --exclude=cache db/#{site}/ dan@zeraweb.com:projects/pages/db/#{site}/"
# 	else
# 		puts "Sync all sites ..."
# 		sh "rsync -avz --exclude=cache db/ dan@zeraweb.com:projects/pages/db/"
# 	end
# end
# 
# task :code_sync do
# 	puts "Code sync ..."
# 	
# 	sh "rsync -avz #{excludes} ./ dan@zeraweb.com:projects/pages/"
# end