class AddDefaultValue < ActiveRecord::Migration
	def change
    change_column :urls, :click_count, :integer, default: 0
    change_column :urls, :long, :string, default: ""		
	end
end
