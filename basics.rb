require 'sinatra'

# The Very Basics

get '/' do
  'Hello, World!'
end

# This is a 'Route'. Here, we're telling Sinatra that if the home, or root, URL '/' is requested,
# using the normal GET HTTP method, to display "Hello, World!"

get '/about' do
  'A little about me. '
end

# This mean if the '/about' URL is requested (using the GET HTTP method), 
# "A little about me." will display.


# Accessing URL Parameters

get '/hello/:name' do
  params[:name] # or "Hello there #{params[:name].upcase}."
end

# We have a route where anything after '/hello/' will be contained in a params array with the key :name. 
# The params array contains all GET and POST variables.

get '/hello/:name/:city' do
  "Hey there #{params[:name]} from #{params[:city]}."
end

# Route to accept multiple query string variables

get '/more/*' do
  params[:splat]
end

# Sinatra allows you to include retrieve wildcard query strings, known as a 'splat', by using an asterisk.
# Anything included in the URL after /more/ will be accessible through the :splat key in the params array.


