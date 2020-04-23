defmodule Pokemon.ClientHelperTest do
  use ExUnit.Case, async: true

  alias Pokemon.ClientHelper

  describe "handle_response/1" do
    test "when given an error returns it as it is" do
      response = {:error, :timeout}
      assert {:error, message} = ClientHelper.handle_response(response)
      assert message == :timeout
    end

    test "when succesful with 200 returns the body" do
      response = {:ok, %Tesla.Env{status: 200, body: "It works!"}}
      assert {:ok, body} = ClientHelper.handle_response(response)
      assert body == "It works!"
    end

    test "when succesful with 404 returns an error" do
      response = {:ok, %Tesla.Env{status: 404, body: "Not Found"}}
      assert {:error, message} = ClientHelper.handle_response(response)
      assert message == :not_found
    end

    test "when succesful with 429 returns an error" do
      response = {:ok, %Tesla.Env{status: 429, body: "Too Many Requests: ..."}}
      assert {:error, message} = ClientHelper.handle_response(response)
      assert message == :too_many_requests
    end

    test "when succesful with another error returns the body" do
      response = {:ok, %Tesla.Env{status: 418, body: "I'm A Teapot!"}}
      assert {:error, message} = ClientHelper.handle_response(response)
      assert message == "I'm A Teapot!"
    end
  end
end
