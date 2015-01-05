require 'sinatra'
require 'datamapper'

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