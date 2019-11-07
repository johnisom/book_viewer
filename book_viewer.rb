require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

before do
  @contents = File.readlines('data/toc.txt', chomp: true)
end

get '/' do
  @title = 'The Adventures of Sherlock Holmes'

  erb :home
end

get '/chapters/:num' do |num|
  @title = "Chapter #{num}: #{@contents[num.to_i - 1]}"
  @chapter = File.read("data/chp#{num}.txt")

  erb :chapter
end
