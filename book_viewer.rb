require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.readlines('data/toc.txt', chomp: true)

  erb :home
end

get '/chapters/:num' do |num|
  @contents = File.readlines('data/toc.txt', chomp: true)
  @title = "Chapter #{num}: #{@contents[num.to_i - 1]}"
  @chapter = File.read("data/chp#{num}.txt")

  erb :chapter
end
