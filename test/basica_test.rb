require_relative "../lib/basica"

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

    assert_equal nil, result
  end

  test "bad request" do
    result = basic_auth(Hash.new) do |user, pass|
      user == "foo" && pass == "baz"
    end

    assert_equal nil, result
  end
end
