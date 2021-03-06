require 'sinatra'
require 'data_mapper'

# Set up database

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")
 
class Note
  include DataMapper::Resource
  property :id, Serial # Will be an integer primary key and auto-incrementing (this is what 'Serial' means)
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end
 
DataMapper.finalize.auto_upgrade!

# The Home Page

get '/' do
  @notes = Note.all :order => :id.desc # retrieves all the notes from the database
  @title = 'All Notes'
	erb :home
end

# Adding a Note to the Database

post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end

# Editing a Note

get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

put '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.complete = params[:complete] ? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end

# Deleting a Note

get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note ##{params[:id]}"
  erb :delete
end

delete '/:id' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end
