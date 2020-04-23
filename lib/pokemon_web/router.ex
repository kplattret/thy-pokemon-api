defmodule PokemonWeb.Router do
  use PokemonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PokemonWeb do
    pipe_through :api

    get "/pokemon/:name", PokemonController, :show
  end
end
