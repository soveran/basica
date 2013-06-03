require File.expand_path("../lib/basica", File.dirname(__FILE__))
include Basica

scope do
  setup do
    "Basic %s" % Base64.encode64("foo:bar")
  end

  test "correct credentials" do |header|
    result = basic_auth("HTTP_AUTHORIZATION" => header) do |user, pass|
      user == "foo" && pass == "bar"
    end

    assert_equal true, result
  end

  test "incorrect credentials" do |header|
    result = basic_auth("HTTP_AUTHORIZATION" => header) do |user, pass|
      user == "foo" && pass == "baz"
    end

    assert_equal false, result
  end

  test "bad request" do
    assert_raise RuntimeError do
      result = basic_auth(Hash.new) do |user, pass|
        user == "foo" && pass == "baz"
      end
    end
  end
end
