#!/usr/bin/env ruby
require 'nokogiri'
require 'json'

require "sinatra"
require "sinatra/reloader"

require 'net/http'
require 'uri'

def getPortletInformation(html_doc)
  portlet_information = []

  len = 0
  html_doc.css(".new_message>tr").each do |tr|

    if(len % 2 == 0)
      info = {}
      info[:time]     = tr.css("td.nw.bb.fss").text.strip
      info[:title]    = tr.css("td:nth-child(2) > a").text.strip
      info[:category] = tr.css("td:nth-child(3) > span").text.strip
      portlet_information.push(info)
    elsif
      _new_message_normal    = tr.css(".new_message_normal").to_html.strip.gsub(/([\r\n　])/,"")
      _new_message_emergency = tr.css(".new_message_emergency").to_html.strip.gsub(/([\r\n　])/,"")
      message = _new_message_emergency.empty? ? _new_message_normal : _new_message_emergency
      portlet_information[-1][:message] = message
    end
    len += 1

  end

  portlet_information
end

post "/" do
  id = params[:id]
  passwd = params[:passwd]
  res = Net::HTTP.post_form(URI.parse('http://localhost:3000/v1'),
                          {'id'=>id, 'passwd'=>passwd})
  html_doc = Nokogiri::HTML(res.body)
  portlet_information = getPortletInformation(html_doc)
  portlet_information.to_json
end


get "/form" do
  erb :form
end


get "/*" do
  "Hello World!"
end
