defmodule LvChat.Meeting do
  @moduledoc """
  The Meeting context.
  """

  import Ecto.Query, warn: false
  alias LvChat.Repo

  alias LvChat.Meeting.Board
  alias LvChat.Accounts

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """
  def list_boards do
    Repo.all(Board)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
def create_board(%Accounts.User{} = user, attrs \\ %{}) do
  %Board{}
  |> Board.changeset(attrs)
  |> Ecto.Changeset.put_assoc(:user, user)
  |> Repo.insert()
end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """
  def change_board(%Board{} = board) do
    Board.changeset(board, %{})
  end

  alias LvChat.Meeting.Comment
  def comment_to_board(%Accounts.User{id: user_id}, board_id, attrs) do
    %Comment{board_id: board_id, user_id: user_id}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def list_comments(%Board{} = board) do
    Repo.all(
      from c in Ecto.assoc(board, :comments),
      order_by: [asc: c.id],
      limit: 500,
      preload: [:user]
    )
  end

  def change_comment() do
    change_comment(%Comment{})
  end

  def change_comment(%Comment{} = comment, params \\ %{}) do
    Comment.changeset(comment, params)
  end


end
