defmodule PokemonWeb.PokemonView do
  use PokemonWeb, :view

  def render("show.json", %{name: name, description: description}) do
    %{
      name: name,
      description: description
    }
  end
end
