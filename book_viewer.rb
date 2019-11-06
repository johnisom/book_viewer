require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.readlines('data/toc.txt', chomp: true)

  erb :home
end

get '/chapters/1' do
  @title = 'The Adventures of Sherlock Holmes'
  @chapter_title = 'Chapter 1'
  @contents = File.readlines('data/toc.txt', chomp: true)
  @chapter = File.read('data/chp1.txt')

  erb :chapter
end
