class RenameCounterField < ActiveRecord::Migration
	def change
		change_table :urls do |t|
			t.rename :counter, :click_count
		end
	end
end
