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


# View Files & POST

get '/form' do
  erb :form
end

# This route will load the form.erb ERB (Embedded Ruby) file from a views/ directory. 
# ERB files are typically normal HTML files which allow you to include Ruby code inside <% … %> tags, 
# which will be parsed before being sent to the browser

post '/form' do
  "You said '#{params[:message]}'"
end

# This route is for the POST method, not GET. 
# Also, all POST variables are available in the same params array as GET variables, 
# so we can retrieve the message submitted with the form.

# Encrypt

get '/secret' do
  erb :secret
end

post '/secret' do
  params[:secret].reverse
end

# we've got a message encryptor which uses a special 'reverse' method to make the message seemingly unreadable, 
# we need a way to decrypt the message

get '/decrypt/:secret' do
  params[:secret].reverse
end

# FourOhFour?
# Create our own 404 error message

not_found do
  status 404
  'not found'
end