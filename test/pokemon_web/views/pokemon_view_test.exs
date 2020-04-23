defmodule PokemonWeb.PokemonViewTest do
  use PokemonWeb.ConnCase, async: true

  import Phoenix.View

  test "renders a Pokemon and its description" do
    params = %{
      name: "charizard",
      description: "Charizard flies 'round the sky in search of powerful opponents."
    }

    assert render(PokemonWeb.PokemonView, "show.json", params) == %{
      description: "Charizard flies 'round the sky in search of powerful opponents.",
      name: "charizard"
    }
  end
end
