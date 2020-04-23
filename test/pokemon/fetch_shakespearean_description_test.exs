defmodule Pokemon.FetchShakespeareanDescriptionTest do
  use ExUnit.Case, async: true

  import Tesla.Mock
  alias Pokemon.FetchShakespeareanDescription

  describe "call/1" do
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

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/pikachu"} ->
          json(%{
            "id" => 25,
            "name" => "pikachu",
            "flavor_text_entries" => [
                  %{
                "flavor_text" => "Its nature is to store up electricity.",
                "language" => %{"name" => "en"}
                  }
                ]
          }, status: 200)

        %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"Charizard flies around the sky in search of powerful opponents.\"}"} ->
          json( %{
            "contents" => %{
              "text" => "Charizard flies around the sky in search of powerful opponents.",
              "translated" => "Charizard flies 'round the sky in search of powerful opponents.",
              "translation" => "shakespeare"
            },
            "success" => %{"total" => 1}
          }, status: 200)

        %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"Its nature is to store up electricity.\"}"} ->
          json(%{
            "error" => %{
              "code" => 429,
              "message" => "Too Many Requests: Rate limit of 5 requests per hour exceeded."
            }
          }, status: 429)
      end)

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
