class RenameColumn < ActiveRecord::Migration
	def change
		change_table :urls do |t|
			t.rename :long_link, :long
			t.rename :short_link, :short
		end
	end
end
