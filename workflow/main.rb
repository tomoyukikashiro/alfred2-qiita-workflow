#!/usr/bin/env ruby
# coding: utf-8
require 'rubygems' unless defined? Gem
require_relative "bundle/bundler/setup"
require_relative "util"
require "alfred"

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true

  query = ARGV[0]
  if query == "auth"
    Util.auth(alfred)
  end
end

