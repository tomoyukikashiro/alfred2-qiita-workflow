#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems' unless defined? Gem
require_relative "bundle/bundler/setup"
require_relative "util"
require_relative "setting"
require_relative "search"
require "alfred"

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  setting = Setting.new(alfred)
  feedback = alfred.feedback
  type = ARGV[0]

  unless type[0] == ">"
    option = setting.api_option(type)
    query = ARGV[1]
    query.dup.force_encoding("UTF-8")

    Util.check_token(option[:access_token])
    Util.check_team(option[:host]) if type == "team"

    Search.get(feedback, option, query, type)
    puts feedback.to_alfred()
  end
end

