require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

def map_to_id(content)
  content.split("\n\n").map.with_index do |paragraph, idx|
    [paragraph, "paragraph-#{idx + 1}"]
  end
end

def each_chapter
  @contents.each_with_index do |title, idx|
    num = idx + 1
    content = File.read("data/chp#{num}.txt")
    yield num, title, map_to_id(content)
  end
end

def filter_content(mapped_content, query)
  mapped_content.filter do |paragraph, _id|
    paragraph.include?(query)
  end
end

def search(query)
  return [] if query.nil? || query.empty?

  results = []
  each_chapter do |num, title, mapped_content|
    filtered = filter_content(mapped_content, query.downcase)
    unless filtered.empty?
      results << { num: num, title: title, mapped_content: filtered }
    end
  end
  results
end

helpers do
  def in_paragraphs(chapter_text)
    chapter_text.split("\n\n").map.with_index do |paragraph, idx|
      %(<p id="paragraph-#{idx + 1}">#{paragraph}</p>)
    end.join
  end

  def highlight(text, to_highlight)
    to_highlight.downcase!
    text.gsub(/#{to_highlight}/i, "<strong>#{to_highlight}</strong>")
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
  @results = search(params[:query])
  erb :search
end

not_found do
  redirect '/'
end
