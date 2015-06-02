#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems' unless defined? Gem
require_relative "bundle/bundler/setup"
require "time"
require "qiita"

class Search
  def self.get(feedback, option, query, type)
    client = Qiita::Client.new(option)
    icon = {type: "default"}
    icon[:name] = type == "team" ? "team-icon.png" : "icon.png"

    response = client.get("/api/v2/items", per_page: 20, query: query)
    return if response.body.nil?

    response.body.each_with_index do | item, index |
      response.body[index]["updated_at"] = Time.parse(item["updated_at"])
    end

    response.body.sort_by! do |item| item["updated_at"]  end

    response.body.each_with_index do | res, index |
      tags = (res["tags"].map do | tag | tag["name"] end).join(',')
      subtitle =  "@#{res["user"]["id"]} / " + res["updated_at"].strftime("%Y/%m/%d %H:%M:%S") + " updated / tags: #{tags}"
      feedback.add_item({
        :uid      => nil          ,
        :title    => res["title"] ,
        :subtitle => subtitle     ,
        :arg      => res["url"]   ,
        :valid    => "yes",
        :order    => response.body.size - index,
        :icon     => icon
      })
    end
  end
end
