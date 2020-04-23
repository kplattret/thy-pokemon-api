defmodule Pokemon.FunTranslationsTest do
  use ExUnit.Case, async: true

  import Pokemon.Mocks
  alias Pokemon.FunTranslations

  describe "shakespeare/1" do
    setup do
      mocks_for_external_apis()
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
