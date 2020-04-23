defmodule PokemonWeb.PokemonController do
  use PokemonWeb, :controller

  alias Plug.Conn.Status
  alias Pokemon.FetchShakespeareanDescription
  alias PokemonWeb.{ErrorView, PokemonView}

  def show(conn, %{"name" => name}) do
    case FetchShakespeareanDescription.call(name) do
      {:ok, description} ->
        conn
        |> put_status(:ok)
        |> put_view(PokemonView)
        |> render("show.json", name: name, description: description)
      {:error, status} ->
        conn
        |> put_status(status)
        |> put_view(ErrorView)
        |> render("#{Status.code(status)}.json")
    end
  end
end
