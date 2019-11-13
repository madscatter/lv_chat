defmodule LvChatWeb.SessionController do
  use LvChatWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"name" => name, "password" => pass}}) do
    case LvChat.Accounts.authenticate_by_name_and_pass(name, pass) do
      {:ok, user} ->
        conn
        |> LvChatWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid name/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> LvChatWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
