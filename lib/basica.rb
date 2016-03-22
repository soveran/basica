require "base64"

module Basica
  HTTP_AUTHORIZATION = "HTTP_AUTHORIZATION".freeze

  def basic_auth(env)
    http_auth = env.fetch(HTTP_AUTHORIZATION) do
      return nil
    end

    cred = http_auth.split(" ")[1]
    user, pass = Base64.decode64(cred).split(":")

    yield(user, pass) || nil
  end
end
