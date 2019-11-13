# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lv_chat,
  ecto_repos: [LvChat.Repo]


# Configures the endpoint
config :lv_chat, LvChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rp5y7ZhwzUq2VhvLPltyUwWV91fgue7ZojuYtp93BPn9y7t/aRXGjlvTHWqAu6ix",
  render_errors: [view: LvChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LvChat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :lv_chat, LvChatWeb.Endpoint,
  live_view: [
    signing_salt: "LgyhjqVtJr6TC9wPEzSjikUoW6gy2qL3"
  ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
