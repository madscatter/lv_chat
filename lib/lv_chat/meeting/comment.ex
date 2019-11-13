defmodule LvChat.Meeting.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string

    belongs_to :user, LvChat.Accounts.User
    belongs_to :board, LvChat.Meeting.Board

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
