#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems' unless defined? Gem
require_relative "bundle/bundler/setup"
require_relative "util"
require_relative "setting"
require "alfred"

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  setting = Setting.new(alfred)
  feedback = alfred.feedback
  query = ARGV[0]

  if query == "token"
    Util.token(setting, ARGV[1])
  elsif query == "team"
    if ARGV[1] == "open"
      Util.open(feedback, "http://#{setting.get("team_host")}/", "team")
    else
      Util.team(setting, ARGV[1])
    end
  elsif ARGV[0] == "qiita" && ARGV[1] == "open"
      Util.open(feedback, "http://qiita.com")
  end
end

