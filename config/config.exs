# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :background_work,
  ecto_repos: [BackgroundWork.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :background_work, BackgroundWorkWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BackgroundWorkWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BackgroundWork.PubSub,
  live_view: [signing_salt: "8FhCMYjS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
