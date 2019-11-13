defmodule LvChatWeb.PageController do
  use LvChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
