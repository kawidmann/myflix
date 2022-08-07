# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :myflix,
  ecto_repos: [Myflix.Repo]

# Configures the endpoint
config :myflix, MyflixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Pm1UDlIdy6IwaLv8QdzYZtYBEPrJJiy60AYnJ6ncCpDKf8Eyo3E/sqHa5zHZQhju",
  render_errors: [view: MyflixWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Myflix.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :phoenix, :json_library, Jason
