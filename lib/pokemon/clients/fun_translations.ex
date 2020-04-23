defmodule Pokemon.FunTranslations do
  use Tesla

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

  defp handle_response({:error, _} = error), do: error
  defp handle_response({:ok, response}) do
    %Tesla.Env{status: status, body: body} = response

    case status do
      200 -> {:ok, body}
      404 -> {:error, :not_found}
      429 -> {:error, :too_many_requests}
      _ -> {:error, body}
    end
  end
end
