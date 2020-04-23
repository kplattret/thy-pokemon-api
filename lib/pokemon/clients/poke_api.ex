defmodule Pokemon.PokeApi do
  use Tesla

  import Pokemon.ClientHelper

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def description(name) do
    get("/pokemon-species/" <> to_string(name))
    |> handle_response
    |> extract_data
  end

  # private

  defp extract_data({:error, _} = error), do: error
  defp extract_data({:ok, body}) do
    if Map.has_key?(body, "flavor_text_entries") do
      english = &(&1["language"]["name"] == "en")
      data = Enum.find(body["flavor_text_entries"], &english.(&1))
      value = Map.fetch!(data, "flavor_text") |> String.replace("\n", " ")

      {:ok, value}
    else
      {:error, :not_found}
    end
  end
end
