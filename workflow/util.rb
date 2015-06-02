#!/usr/bin/env ruby
# coding: utf-8
class Util
  def self.token(setting, token)
    unless token.nil?
      setting.set("token", token)
      Alfred::Util.notify(nil, "Saved Token", {title: "Alfred Qiita"})
    end
  end
  def self.team(setting, domain)
    if !domain.blank?
      setting.set("team_host", "#{domain}.qiita.com")
      Alfred::Util.notify(nil, "Saved Team / #{domain}", {title: "Alfred Qiita"})
    end
  end

  def self.check_team(host)
    if host.blank?
      raise Alfred::InvalidArgument, "need to set team setting"
    end
  end

  def self.check_token(token)
    if token.nil?
      raise Alfred::InvalidArgument, "need to set access token"
    end
  end
end

