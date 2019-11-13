defmodule LvChat.Repo do
  use Ecto.Repo,
    otp_app: :lv_chat,
    adapter: Ecto.Adapters.Postgres
end
