require 'pp'



get '/' do
	puts "[LOG] Getting /"
	puts "[LOG] Params: #{params.inspect}"
  @urls = Url.all
  @alert_msg = ""

  erb :"static/index"

end

post '/urls' do
	# create a new Url
	# p params[:url]
	# p long_url = params[:url][:long]
	
	# @new_url = Url.create params[:url]
	# @urls = Url.all

	if Url.valid_url?(params[:url][:long])
    @new_url = Url.find_or_initialize_by(params[:url])
	  if @new_url.save 
	  	@alert_msg = ""  	
	  else
	  	p @new_url.errors.messages
	  	@alert_msg = "There is a problem with your link"
  	end

	else
	  	@alert_msg = "'#{params[:url][:long]}'' is not a valid URL."
	end

  @urls = Url.all
	erb :"static/index"

end



post '/ajax' do
	# JQuery will receive the return value of this method
	# in the response 
	# And Ruby will return the value to JQuery 
	# from the the last line of the method.

	p "ajax"
	
	if Url.valid_url?(params[:url][:long])
		# @new_url = Url.new(params[:url])

    # will not create a new object if we can find in the table
    @new_url = Url.find_or_initialize_by(params[:url])
		
		# don't update table if it is existed
		if @new_url.id == nil
		  if @new_url.save 
		  	# @new_url.to_json
		  	{existed: "0", url_object: @new_url}.to_json
		  else
		  	# byebug
		  	# p @new_url.errors.messages
		  	# @alert_msg = '{"alert_msg": "There is a problem with your link"}'
				{alert_msg: "There is a problem with your link"}.to_json

	  	end
	  else
	  	# byebug
	  	{existed: "1", url_object: @new_url}.to_json
	  end
	else
			# @alert_msg = '{"alert_msg": "Not a valid URL"}'
			{alert_msg: "Not a valid URL"}.to_json
	  	
	end

end


post '/ajax_key' do
	# JQuery will receive the return value of this method
	# in the response 
	# And Ruby will return the value to JQuery 
	# from the the last line of the method.

	p "ajax KEY"
	# byebug
	if Url.valid_url?(params[:url][:long])
		# @new_url = Url.new(params[:url])
    # will not create a new object if we can find in the table
    @new_url = Url.find_or_initialize_by(params[:url])
	  
		if @new_url.id == nil
		  if @new_url.save 
		  	# @alert_msg = "" 
		  	# @new_url.to_json 	
		  	{existed: "0", url_object: @new_url}.to_json
		  else
		  	# p @new_url.errors.messages
		  	# p @new_url.errors	  	
				# @alert_msg = '{"alert_msg": "There is a problem with your link"}'
				{alert_msg: "There is a problem with your link"}.to_json
	  	end
		else
			# byebug
	  	{existed: "1", url_object: @new_url}.to_json
		end

  else
  	@alert_msg = nil
	end

end







get '/:short_url' do
	# redirect to appropirate "long" URL
	# this will fetch the short_url in the table and redirect it to the long link

	p params[:short_url]

	# ori_link = Url.where(short: params[:short_url])
	# if ori_link.valid?
	# 	p "horraaay"
	# else
	# 	p "OH nooo"
	# end

	if Url.where(short: params[:short_url]).count(:id) > 0
		ori_link = Url.where(short: params[:short_url]).first

		ori_link.add_click_count
		ori_link.save
		
		# byebug

		# redirect to("https://" + ori_link.long)
		redirect to("https://" + ori_link.long.gsub(/(http)[s]*[:](\/\/)/, ''))
	else
		@urls = Url.all
		@alert_msg = "invalid short url"

		#redirect to('/')

		erb :"static/index"
	end

end