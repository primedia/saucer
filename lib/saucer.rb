require 'faraday'
require 'faraday_middleware'
require 'environs'
require 'pmap'
require 'memoist'
require 'virtus'
require 'require_all'

require_all "lib/saucer/**/*.rb"

module Saucer
end
