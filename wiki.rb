# frozen_string_literal: true

require 'sinatra'
require 'uri'

set :bind, '0.0.0.0'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", 'w') do |file|
    file.print(content)
  end
end

def delete_content(title)
  File.delete("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

get '/' do
  erb :welcome, layout: :page
end

get '/new' do
  erb :new, layout: :page
end

get '/:title' do
  @title = params[:title]
  @content = page_content(@title)
  erb :show, layout: :page
end

get '/:title/edit' do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit, layout: :page
end

# {"title" => "my title", "content" => "my content"}
post '/create' do
  save_content(params['title'], params['content'])
  redirect URI.escape "/#{params['title']}"
end

put '/:title' do
  save_content(params['title'], params['content'])
  redirect URI.escape "/#{params['title']}"
end

delete '/:title' do
  delete_content(params[:title])
  redirect '/'
end

