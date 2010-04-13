require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'posty'
    gem.summary = %Q{Simple geolocation gem that stores the database locally}
    gem.description = %Q{}
    gem.email = 'tom@thedextrousweb.com'
    gem.homepage = 'http://github.com/dxw/posty'
    gem.authors = ['Tom Adams']
    gem.add_dependency 'sqlite3-ruby'
    gem.add_dependency 'choice'
    gem.add_dependency 'fastercsv'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
