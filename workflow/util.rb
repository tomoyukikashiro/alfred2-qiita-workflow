#!/usr/bin/env ruby
# coding: utf-8
require_relative "auth_server"
require_relative "setting"

class Util
  def self.auth(alfred)
    fb = alfred.feedback
    @@setting ||= Setting.new(alfred)
    url = @@setting.auth_url
    fb.add_item({
      uid:      nil,
      title:    "authorize Qiita",
      subtitle: nil,
      arg:      url,
      valid:    "yes"
    })
    puts fb.to_xml("auth")
    AuthServer.start(@@setting)
  end
end

