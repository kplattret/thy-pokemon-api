defmodule Pokemon.ClientHelper do
  def handle_response({:error, _} = error), do: error
  def handle_response({:ok, response}) do
    %Tesla.Env{status: status, body: body} = response

    case status do
      200 -> {:ok, body}
      404 -> {:error, :not_found}
      429 -> {:error, :too_many_requests}
      _ -> {:error, body}
    end
  end
end
