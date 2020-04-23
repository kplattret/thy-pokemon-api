defmodule PokemonWeb.PokemonControllerTest do
  use PokemonWeb.ConnCase

  import Pokemon.Mocks

  setup %{conn: conn} do
    mocks_for_external_apis()

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show/2" do
    test "when input is valid renders description", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :show, "charizard"))

      assert %{
        "description" => "Charizard flies 'round the sky in search of powerful opponents.",
        "name" => "charizard"
      } = json_response(conn, 200)
    end

    test "when input is not lowercase renders 404 error", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :show, "Pikachu"))
      assert %{"errors" => %{"detail" => "Not Found"}} = json_response(conn, 404)
    end

    test "when input is blank renders 404 error", %{conn: conn} do
      assert_raise Phoenix.Router.NoRouteError,
        "no route found for GET /pokemon (PokemonWeb.Router)", fn ->
        get(conn, Routes.pokemon_path(conn, :show, ""))
      end
    end

    test "when we're being rate-limited renders 429 error", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :show, "pikachu"))
      assert %{"errors" => %{"detail" => "Too Many Requests"}} = json_response(conn, 429)
    end
  end
end
