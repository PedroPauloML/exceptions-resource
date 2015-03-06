module Exceptions
end

Dir["#{File.expand_path('../exceptions', __FILE__)}/*.rb"].each { |f| require f }
