#!/usr/bin/env ruby
require 'saucer'
require 'stackprof'

Dir.mkdir('tmp') unless Dir.exists?('tmp')
output = 'tmp/stackprof-cpu-myapp.dump'
StackProf.run(mode: :wall, out: output) do
  client = Saucer::Client.new
  client.jobs(500)
end
