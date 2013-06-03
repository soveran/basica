basica
======

Basic authentication library.

Description
-----------

Basic authentication library suited for Cuba apps.

## Usage

Include the Basica module in your application, then call it
by passing the `env` hash (should be available in every Rack
based application) and a block. If the `env` hash contains the
`HTTP_AUTHORIZATION` header, then the username and password will
be passed to the block.

The result of the method call to `basic_auth` will be that of
the block. If the `HTTP_AUTHORIZATION` header is not found, a
`RuntimeError` is raised.

## Example

First, an example of Basica in the wild:

```ruby
require "basica"

include Basica

header = "Basic %s" % Base64.encode64("foo:bar")

result = basic_auth("HTTP_AUTHORIZATION" => header) do |user, pass|
  user == "foo" && pass == "bar"
end

if result
  # The right credentials were provided.
end
```

Now an example of how to use it with [Cuba][cuba] and
[Shield][shield]:

```ruby
Cuba.plugin Basica

Cuba.define do
  on env["HTTP_AUTHORIZATION"].nil? do
    res.status = 401
    res.headers["WWW-Authenticate"] = 'Basic realm="MyApp"'
    res.write "Unauthorized"
  end

  basic_auth(env) do |user, pass|
    login(User, user, pass)
  end

  on authenticated(User) do
    run Users
  end
end
```

Note that the previous example assumes you have already required
Cuba, Shield, Basica, and that you have a User model defined.

[cuba]: http://cuba.is
[shield]: http://cyx.github.io/shield/

## Installation

Install it using rubygems.

```
$ gem install basica
```
