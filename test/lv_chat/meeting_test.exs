defmodule LvChat.MeetingTest do
  use LvChat.DataCase

  alias LvChat.Meeting

  describe "boards" do
    alias LvChat.Meeting.Board

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meeting.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Meeting.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Meeting.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Meeting.create_board(@valid_attrs)
      assert board.description == "some description"
      assert board.name == "some name"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meeting.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, %Board{} = board} = Meeting.update_board(board, @update_attrs)
      assert board.description == "some updated description"
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Meeting.update_board(board, @invalid_attrs)
      assert board == Meeting.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Meeting.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Meeting.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Meeting.change_board(board)
    end
  end
end
