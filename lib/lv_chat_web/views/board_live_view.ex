defmodule LvChatWeb.BoardLiveView do
  use Phoenix.LiveView
  alias LvChatWeb.BoardView
  alias LvChatWeb.Presence
  alias LvChat.Meeting


  defp topicId(board_id) do
    "board:#{board_id}"
  end

  def render(assigns) do
    Phoenix.View.render(BoardView, "show.html", assigns)
  end

  def mount(session = %{current_user: user, board: board}, socket) do
    Presence.track_presence(
      self(),
      board.id |> topicId,
        user.id,
      %{
        name: user.name,
        id: user.id,
        typing: false
      }
    )

    assigns =
      Map.merge(
        session,
        %{
          comments: board |> Meeting.list_comments,
          comment:  LvChat.Meeting.change_comment,
          users:
            session.board.id
            |> topicId
            |> Presence.list_presences(),
        }
      )

    session.board.id
    |> topicId
    |> LvChatWeb.Endpoint.subscribe

    {:ok, assign(socket, assigns)}
  end

  def handle_event(
        "add_comment",
        %{"comment" => cmnt},
        socket = %{assigns: %{board: board, current_user: user}}
      ) do
    IO.inspect(cmnt)
    case Meeting.comment_to_board(user, board.id, cmnt) do
      {:ok, _comment} ->
        comments = board |> Meeting.list_comments
        LvChatWeb.Endpoint.broadcast_from(self(), board.id |> topicId, "broadcast_comment", %{
          comments: comments
        })

        {:noreply, assign(socket, comment: LvChat.Meeting.change_comment, comments: comments)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  def handle_event("typing", _value, socket = %{assigns: %{board: board, current_user: user}}) do
    topic = board.id |> topicId
    key = user.id
    payload = %{typing: true}
    Presence.update_presence(self(), topic, key, payload)
    {:noreply, socket}
  end

  def handle_event(
        "stop_typing",
        %{"value" => val},
        socket = %{assigns: %{board: board, current_user: user}}
      ) do
    topic = board.id |> topicId
    key = user.id
    payload = %{typing: false}

    comment = LvChat.Meeting.change_comment(%Meeting.Comment{},%{body: val})

    Presence.update_presence(self(), topic, key, payload)
    {:noreply, assign(socket, comment: comment)}
  end

  def handle_event("scroll_change", %{"value" => _val}, socket) do
    {:noreply, socket}
  end

  def handle_info(%{event: "broadcast_comment", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  def handle_info(%{event: "presence_diff"}, socket = %{assigns: %{board: board}}) do
    {:noreply, assign(socket, users: board.id |> topicId |> Presence.list_presences)}
  end
end
