defmodule Pokemon.PokeApiTest do
  use ExUnit.Case, async: true

  import Pokemon.Mocks
  alias Pokemon.PokeApi

  describe "description/1" do
    setup do
      mocks_for_external_apis()
      :ok
    end

    test "when Pokemon name is valid returns corresponding description" do
      assert {:ok, body} = PokeApi.description("charizard")
      assert body == "Charizard flies around the sky in search of powerful opponents."
    end

    test "when Pokemon ID is valid returns corresponding description" do
      assert {:ok, body} = PokeApi.description(6)
      assert body == "Charizard flies around the sky in search of powerful opponents."
    end

    test "when Pokemon name is not valid returns a 404 error" do
      assert {:error, message} = PokeApi.description("Charizard")
      assert message == :not_found
    end

    test "when Pokemon name is blank returns a 404 error" do
      assert {:error, message} = PokeApi.description("")
      assert message == :not_found
    end

    test "when Pokemon name is null returns a 404 error" do
      assert {:error, message} = PokeApi.description(nil)
      assert message == :not_found
    end
  end
end
