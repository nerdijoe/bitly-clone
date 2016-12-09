require 'csv'
require 'pp'

class UrlImporter
  def self.import(filename)
    # csv = CSV.new(File.open(filename), :headers => true)
    # csv = CSV.new(File.open(filename))
    # values = Array.new
    # csv.each do |row|
    #   # before pushing to array, generate short link
    #   # row[1] = Url.seed_shorten
    #   pp row
    #   # values.push(row)
    # end

    # CSV each vs foreach
    # each will load the whole file in the memory
    # foreach will read the file line by line, after reading a line, it will dispose it.

    CSV.foreach(filename) do |row|
      
      row[0].gsub!(/^[(]/, '').gsub!(/[)]/, '')
      row[1] = Url.seed_shorten
      pp row

      Url.transaction do
        Url.connection.execute "INSERT INTO urls (long, short) VALUES ('#{row[0]}', '#{row[1]}');"
      end

    end

  end # end of UrlImporter


end
