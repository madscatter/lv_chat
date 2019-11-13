use Mix.Config

# Configure your database
config :lv_chat, LvChat.Repo,
  username: "postgres",
  password: "postgres",
  database: "lv_chat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lv_chat, LvChatWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
