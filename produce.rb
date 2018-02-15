# frozen_string_literal: true

require 'sinatra'

set :bind, '0.0.0.0'

get('/apple') do
  "Here's a juicy apple"
end

get('/banana') do
  "<h1>Here's a ripe banana</h1>"
end

get('/carrot') do
  "<h1>Here's a crunchy carrot</h1>"
end