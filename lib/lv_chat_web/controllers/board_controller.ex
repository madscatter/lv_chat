defmodule LvChatWeb.BoardController do
  use LvChatWeb, :controller

  alias LvChat.Meeting
  alias LvChat.Meeting.Board

  alias Phoenix.LiveView

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    boards = Meeting.list_boards()

    render(conn, "index.html", boards: boards, current_user: current_user)
  end

  def new(conn, _params,  _current_user) do
    changeset = Meeting.change_board(%Board{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"board" => board_params}, current_user) do
    case Meeting.create_board(current_user, board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: Routes.board_path(conn, :show, board))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    board = Meeting.get_board!(id)

    LiveView.Controller.live_render(
      conn,
      LvChatWeb.BoardLiveView,
      session: %{
        board: board,
        current_user: current_user,
      }
    )
  end

  def edit(conn, %{"id" => id}, _current_user) do
    board = Meeting.get_board!(id)
    changeset = Meeting.change_board(board)
    render(conn, "edit.html", board: board, changeset: changeset)
  end

  def update(conn, %{"id" => id, "board" => board_params}, _current_user) do
    board = Meeting.get_board!(id)

    case Meeting.update_board(board, board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board updated successfully.")
        |> redirect(to: Routes.board_path(conn, :show, board))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", board: board, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _current_user) do
    board = Meeting.get_board!(id)
    {:ok, _board} = Meeting.delete_board(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: Routes.board_path(conn, :index))
  end
end
