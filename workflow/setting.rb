#!/usr/bin/env ruby
# coding: utf-8
class Setting
  def initialize(alfred)
    @setting ||= Alfred::Setting.new(alfred)
    @setting.dump
  end

  def api_option(type)
    {
      access_token: self.get("token"),
      host: type == "team" ? self.get("team_host") : nil
    }
  end

  def get(key)
    begin
      @setting[key.to_sym]
    rescue NameError => ex
      generate alfred
      get alfred, key
    end
  end

  def set(key, value)
    begin
      @setting[key.to_sym] = value
      @setting.dump
    rescue NameError => ex
      generate alfred
      set alfred, key, value
    end
  end
end
