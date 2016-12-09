require 'csv'

class UrlImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      p row

    end
  end
end
