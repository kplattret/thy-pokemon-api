# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pokemon, PokemonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ejYh16GuXc8gtroIIAsD6cXTRg/sQjKY76qChGiXCG3gmoy1GenYuyAVrTyfWZwN",
  render_errors: [view: PokemonWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Pokemon.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Tesla for HTTP requests, with the recommended Hackney adapter
config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
