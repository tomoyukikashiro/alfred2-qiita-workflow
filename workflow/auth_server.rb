require "webrick"
require "qiita"
include WEBrick

class AuthServer
  def self.start(setting)
    @@setting = setting
    server = HTTPServer.new(Port: 8080, ServerType: WEBrick::Daemon)
    server.mount("/qiita-auth", AuthServer::QiitaAuth)
    server.start
  end
  def self.setting
    @@setting
  end
end
class AuthServer::QiitaAuth < HTTPServlet::AbstractServlet
  def do_GET(req, res)
    res['Content-Type'] = "text/html"
    res.body = "<html><body>Complete Qiita authorization</body></html>"
    @server.shutdown
    client = Qiita::Client.new
    response = client.create_access_token({
      client_id: AuthServer.setting.get("client_id"),
      client_secret: AuthServer.setting.get("client_secret"),
      code: req.query["code"]
    })
    AuthServer.setting.set("token", response.body["token"])
  end
end
