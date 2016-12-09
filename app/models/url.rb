=begin
+------------+
| urls       |
+------------+
| ori_link   |
| short_link |
+------------+
=end
require 'securerandom'

class Url < ActiveRecord::Base
	before_create :shorten
	#http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html

	validates :long, presence: true

	# This is Sinatra! Remember to create a migration!
	def shorten
		p "** #{self.id} | #{self.long}"
		# self.short = Base64.urlsafe_encode64("rudy" + "[#{self.id}]")
		# self.short = Base64.urlsafe_encode64("rudy" + Time.now.to_i.to_s)
		self.short = Base64.urlsafe_encode64(Time.now.to_i.to_s + SecureRandom.base64(5))

		# can use SecureRandom

		p "**** #{self.short}"

	end

	def add_click_count
		self.click_count += 1
	end

	def self.valid_url?(str)
		# return true if not valid, otherwise false
		if str =~ /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
			puts "valid url = #{str}"
			return true
		else
			return false
		end
	end

	def self.seed_shorten
		# p "seed shorten"
		short = Base64.urlsafe_encode64(Time.now.to_i.to_s + SecureRandom.base64(5))
		# p short
	end

end

