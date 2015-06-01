require "uri"

class Setting
  def initialize(alfred)
    @setting ||= Alfred::Setting.new(alfred)
    @setting[:base_url] = "https://qiita.com/api/v2/oauth/authorize?"
    @setting[:client_id] = "3055bc3e0af06a6254d17655b860f8678b6e54f9"
    @setting[:client_secret] = "70789087b130568b372f84d60a67ba10cf5c8f86"
    @setting[:api_scope] = "read_qiita read_qiita_team"
    @setting.dump
  end

  def auth_url
    url = self.get("base_url")
    query = { "client_id"=> self.get("client_id"), "scope"=> self.get("api_scope")}
    url + URI.encode_www_form(query)
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
