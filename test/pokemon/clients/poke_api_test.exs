defmodule Pokemon.PokeApiTest do
  use ExUnit.Case, async: true

  import Tesla.Mock
  alias Pokemon.PokeApi

  describe "description/1" do
    setup do
      mock(fn
        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/charizard"} ->
          json(%{
            "id" => 6,
            "name" => "charizard",
            "flavor_text_entries" => [
              %{
                "flavor_text" => "Dracaufeu parcourt les cieux\npour trouver des adversaires.",
                "language" => %{"name" => "fr"}
              },
              %{
                "flavor_text" => "Charizard flies around the sky\nin search of powerful opponents.",
                "language" => %{"name" => "en"}
              }
            ]
          }, status: 200)

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/6"} ->
          json(%{
            "id" => 6,
            "name" => "charizard",
            "flavor_text_entries" => [
              %{
                "flavor_text" => "Dracaufeu parcourt les cieux\npour trouver des adversaires.",
                "language" => %{"name" => "fr"}
              },
              %{
                "flavor_text" => "Charizard flies around the sky\nin search of powerful opponents.",
                "language" => %{"name" => "en"}
              }
            ]
          }, status: 200)

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/Charizard"} ->
          text("Not Found", status: 404)

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/"} ->
          json(%{"count" => 807}, status: 200)
      end)

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
