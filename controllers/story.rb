module Pages

	module Controllers
		
		class Story < Default
			
			# this is need only because the story editor has a check box for choosing the related blog.
			def update( name )
			   str = find( name )
			   #updating relation with blog 
 			   sel_b = query[ model_name ].to_h['blog']
 			   model_b = models('blog').find(sel_b)
 			   unless model_b.nil?
 			     model_b.entries.push( str )
 			     model_b.save
 			     
 			     #Hack for updating twitter status
   			  tw_acc = site.twitter_account || ""
          tw_pwd = site.twitter_password || ""

           if(!tw_acc.empty? && !tw_pwd.empty?)
   			    require 'twitter'
   			        tweet = str.title 
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
			   #updating story entry
			   str.assign( query[ model_name ].to_h ).save
			end
			
		end
		
	end

end
