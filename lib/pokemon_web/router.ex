defmodule PokemonWeb.Router do
  use PokemonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PokemonWeb do
    pipe_through :api
  end
end
