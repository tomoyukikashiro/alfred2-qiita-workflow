#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems' unless defined? Gem
require_relative "bundle/bundler/setup"
require "time"
require "alfred"
require "qiita"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  query = ARGV[0].dup
  query.force_encoding('UTF-8')

  client = Qiita::Client.new(access_token: "9cfcc8d35cefc93e4561691083c3dabfb11bfd99", host: "bracket", host: "bracket.qiita.com")
  response = client.get("/api/v2/items", per_page: 10, query: query)

  return if response.body.nil?

  response.body.each_with_index do | item, index |
    response.body[index]["updated_at"] = Time.parse(item["updated_at"])
  end
  response.body.sort_by! do |item| item["updated_at"]  end

  response.body.each do | res |
    tags = (res["tags"].map do | tag | tag["name"] end).join(',')
    subtitle =  res["updated_at"].strftime("%Y/%m/%d %H:%M:%S") + " updated / tags: #{tags}"
    fb.add_item({
      :uid      => nil          ,
      :title    => res["title"] ,
      :subtitle => subtitle     ,
      :arg      => res["url"]   ,
      :valid    => "yes"
    })
  end

  puts fb.to_xml(query)
end
