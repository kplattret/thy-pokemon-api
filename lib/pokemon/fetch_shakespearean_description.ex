defmodule Pokemon.FetchShakespeareanDescription do
  alias Pokemon.{FunTranslations, PokeApi}

  def call(name) do
    name
    |> to_string
    |> validate_input
    |> fetch_external_data(:description)
    |> fetch_external_data(:translation)
  end

  # private

  defp fetch_external_data({:error, _} = error, _type), do: error
  defp fetch_external_data({:ok, input}, type) do
    case type do
      :description -> PokeApi.description(input)
      :translation -> FunTranslations.shakespeare(input)
    end
  end

  defp validate_input(string) do
    if String.match?(string, ~r/^[[:lower:]]+$/) do
      {:ok, string}
    else
      {:error, :not_found}
    end
  end
end
