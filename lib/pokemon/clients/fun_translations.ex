defmodule Pokemon.FunTranslations do
  use Tesla

  import Pokemon.ClientHelper

  plug Tesla.Middleware.BaseUrl, "https://api.funtranslations.com"
  plug Tesla.Middleware.JSON

  def shakespeare(text) do
    post("/translate/shakespeare.json", %{text: to_string(text)})
    |> handle_response
    |> extract_data
  end

  # private

  defp extract_data({:error, _} = error), do: error
  defp extract_data({:ok, body}) do
    if Map.has_key?(body, "contents") do
      value = Map.fetch!(body["contents"], "translated")

      {:ok, value}
    else
      {:error, :internal_server_error}
    end
  end
end
