require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.readlines('data/toc.txt', chomp: true)

  erb :home
end

get '/chapters/:num' do |num|
  @title = 'The Adventures of Sherlock Holmes'
  @chapter_title = "Chapter #{num}"
  @contents = File.readlines('data/toc.txt', chomp: true)
  @chapter = File.read("data/chp#{num}.txt")

  erb :chapter
end
