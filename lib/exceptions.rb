exceptions = File.expand_path('../exceptions', __FILE__)
$LOAD_PATH.unshift(exceptions)

module Exceptions
end

require 'exceptions/base'
require 'exceptions/model'
require 'exceptions/resource'
require 'exceptions/simple'
require 'exceptions/unauthorized_application'
