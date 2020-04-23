defmodule Pokemon.FunTranslationsTest do
  use ExUnit.Case, async: true

  import Tesla.Mock
  alias Pokemon.FunTranslations

  describe "shakespeare/1" do
    setup do
      mock(fn
        %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"Your Pokemon API.\"}"} ->
          json( %{
            "contents" => %{
              "text" => "Your Pokemon API.",
              "translated" => "Thy pokemon api.",
              "translation" => "shakespeare"
            },
            "success" => %{"total" => 1}
          }, status: 200)

        %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"\"}"} ->
          json(%{
            "contents" => %{
              "text" => "",
              "translated" => "",
              "translation" => "shakespeare"
            },
            "success" => %{"total" => 1}
          }, status: 200)

        %{method: :post, url: "https://api.funtranslations.com/translate/shakespeare.json",
        body: "{\"text\":\"After so many requests...\"}"} ->
          json(%{
            "error" => %{
              "code" => 429,
              "message" => "Too Many Requests: Rate limit of 5 requests per hour exceeded."
            }
          }, status: 429)
      end)

      :ok
    end

    test "when input is a string returns a valid translation" do
      assert {:ok, body} = FunTranslations.shakespeare("Your Pokemon API.")
      assert body == "Thy pokemon api."
    end

    test "when input is an empty string returns an empty translation" do
      assert {:ok, body} = FunTranslations.shakespeare("")
      assert body == ""
    end

    test "when input is null returns an empty translation" do
      assert {:ok, body} = FunTranslations.shakespeare(nil)
      assert body == ""
    end

    test "when we're being rate-limited returns a 429 error" do
      assert {:error, message} = FunTranslations.shakespeare("After so many requests...")
      assert message == :too_many_requests
    end
  end
end
