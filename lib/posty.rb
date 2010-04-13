require 'sqlite3'

class PostCode
  attr_reader :data
  def initialize(data)
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
  def initialize(database)
    @db = SQLite3::Database.new(database)
    @db.results_as_hash = true
  end

  def postcode code
    code.gsub!(/[^\w\d]/,'')
    code.upcase!
    PostCode.new(@db.get_first_row('SELECT * FROM codepoint WHERE postcode = ?', code))
  end
end
