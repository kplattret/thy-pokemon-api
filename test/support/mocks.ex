defmodule Pokemon.Mocks do
  import Tesla.Mock

  def mocks_for_external_apis do
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

      %{method: :get, url: "https://pokeapi.co/api/v2/pokemon-species/Pikachu"} ->
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

      %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"Your Pokemon API.\"}"} ->
        json( %{
          "contents" => %{
            "text" => "Your Pokemon API.",
            "translated" => "Thy pokemon api.",
            "translation" => "shakespeare"
          },
          "success" => %{"total" => 1}
        }, status: 200)

      %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"\"}"} ->
        json(%{
          "contents" => %{
            "text" => "",
            "translated" => "",
            "translation" => "shakespeare"
          },
          "success" => %{"total" => 1}
        }, status: 200)

      %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"After so many requests...\"}"} ->
        json(%{
          "error" => %{
            "code" => 429,
            "message" => "Too Many Requests: Rate limit of 5 requests per hour exceeded."
          }
        }, status: 429)
    end)
  end
end
