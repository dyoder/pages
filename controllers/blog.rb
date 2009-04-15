module Pages

	module Controllers
		
		class Blog < Default
			
			def update( name )
			  
			  #Hack for updating twitter status
			  tw_acc = site.twitter_account || ""
        tw_pwd = site.twitter_password || ""
       
        if(!tw_acc.empty? && !tw_pwd.empty?)
			    require 'twitter'
			    old = []
			    self.find(name).entries.each{|s| old << s.key}
			    added = query[model_name].entries - old
			    if added.size == 1
			      added_story = models(:story).find(added[0])
			      if added_story
			        tweet = added_story.title 
			        puts tweet  
			        if tweet
			          httpauth = Twitter::HTTPAuth.new(site.twitter_account, site.twitter_password)
                base = Twitter::Base.new(httpauth)
                site_url = " http://" + domain
                if(tweet.length > (140 - site_url.length))
                  tweet = tweet[0, (138 - site_url.length)] + ".."
                end
                puts tweet
                puts tweet.length
                base.update(tweet + site_url)
              end
			      end
			    end
		    end
			  
			  # Hack for supporting single story added to the blog
			  query[model_name].entries = query[model_name].entries.to_a if query[model_name].entries
			  find( name ).assign( query[ model_name ].to_h ).save
			end
			
		end
		
	end

end