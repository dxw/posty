require 'sqlite3'

class PostCode
  attr_reader :data
  def initialize data
    @data = {}
    data.each_pair do |a,b|
      @data[a] = b if a.is_a? String
    end

    @data['latitude'] = @data['latitude'].to_f
    @data['longitude'] = @data['longitude'].to_f
  end

  %w[postcode quality latitude longitude country nhs_region nhs_health_authority county district ward].each do |m|
    define_method(m) {@data[m]}
  end
end

class Posty
  def initialize database = nil
    if database.nil?
      database = Posty.gem_database
      unless File.exist? database
        raise IOError, "No database found in gem. Have you run posty-init -g (possibly with sudo)?"
      end
    end

    unless File.exist? database
      raise IOError, "No database found at #{database}. Have you run posty-init -d '#{database}'?"
    end

    @db = SQLite3::Database.new(database)
    @db.results_as_hash = true
  end

  def postcode code
    code = code.gsub(/[^\w\d]/,'').upcase
    PostCode.new(@db.get_first_row('SELECT * FROM codepoint WHERE postcode = ?', code))
  end

  def self.gem_database
    "#{File.dirname(__FILE__)}/posty/codepointopen.sqlite3"
  end

  def self.postcode code, database = nil
    Posty.new(database).postcode(code)
  end
end
