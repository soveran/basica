require "base64"

module Basica
  def basic_auth(env)
    if env["HTTP_AUTHORIZATION"]
      auth = env["HTTP_AUTHORIZATION"].split(" ")[1]
      user, pass = Base64.decode64(auth).split(":")

      yield user, pass
    else
      raise "Bad request"
    end
  end
end
