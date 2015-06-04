#!/usr/bin/env ruby
# coding: utf-8
class Util
  def self.token(setting, token)
    unless token.nil?
      setting.set("token", token)
      #Alfred::Util.notify(nil, "Saved Token", {title: "Alfred Qiita"})
      puts "Save Token"
    end
  end
  def self.team(setting, domain)
    if !domain.blank?
      setting.set("team_host", "#{domain}.qiita.com")
      #Alfred::Util.notify(nil, "Saved Team / #{domain}", {title: "Alfred Qiita"})
      puts "Save Team / #{domain}"
    end
  end
  def self.open(feedback, url, type=nil)
    icon = {type: "default"}
    icon[:name] = type == "team" ? "team-icon.png" : "icon.png"

      feedback.add_item({
        :uid      => nil          ,
        :title    => "open #{url}",
        :arg      => url          ,
        :valid    => "yes"        ,
        :icon     => icon
      })
      puts feedback.to_alfred()
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

