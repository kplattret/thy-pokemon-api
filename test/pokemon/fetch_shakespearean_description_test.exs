defmodule Pokemon.FetchShakespeareanDescriptionTest do
  use ExUnit.Case, async: true

  import Pokemon.Mocks
  alias Pokemon.FetchShakespeareanDescription

  describe "call/1" do
    setup do
      mocks_for_external_apis()
      :ok
    end

    test "when Pokemon name is valid returns a translated description" do
      assert {:ok, value} = FetchShakespeareanDescription.call("charizard")
      assert value == "Charizard flies 'round the sky in search of powerful opponents."
    end

    test "when Pokemon name is not lowercase returns a 404 error" do
      assert {:error, message} = FetchShakespeareanDescription.call("Charizard")
      assert message == :not_found
    end

    test "when Pokemon name is not just letters returns a 404 error" do
      assert {:ok, value} = FetchShakespeareanDescription.call(6)
      assert value == "Charizard flies 'round the sky in search of powerful opponents."
    end

    test "when Pokemon name is blank returns a 404 error" do
      assert {:error, message} = FetchShakespeareanDescription.call("")
      assert message == :not_found
    end

    test "when we're being rate-limited returns a 429 error" do
      assert {:error, message} = FetchShakespeareanDescription.call("pikachu")
      assert message == :too_many_requests
    end
  end
end
