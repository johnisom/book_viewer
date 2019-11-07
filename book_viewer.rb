require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

helpers do
  def in_paragraphs(chapter_text)
    chapter_text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end

before do
  @contents = File.readlines('data/toc.txt', chomp: true)
end

get '/' do
  @title = 'The Adventures of Sherlock Holmes'

  erb :home
end

get '/chapters/:num' do |num|
  num = num.to_i

  redirect '/' unless (1..@contents.size).cover?(num)

  @title = "Chapter #{num}: #{@contents[num.to_i - 1]}"
  @chapter = File.read("data/chp#{num}.txt")

  erb :chapter
end

get '/search/?' do
  erb :search
end

not_found do
  redirect '/'
end
