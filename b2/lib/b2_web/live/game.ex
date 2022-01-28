defmodule B2Web.Live.Game do

  use B2Web, :live_view

  def mount(__params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = socket
      |> assign(%{ game: game, tally: tally})
    {:ok, socket}
  end

  def handle_event("make_move", %{ "key" => key_stroke},socket) do
    tally = Hangman.make_move(socket.assigns.game, key_stroke)
    {:noreply, assign(socket, :tally, tally)}
  end

  def render(assigns) do
    ~L"""
      <div class="game-holder" phx-window-keyup="make_move">
        <%= live_component(__MODULE__.Figure, tally: assigns.tally, id: 1) %>
        <%= live_component(__MODULE__.Alphabet, tally: assigns.tally, id: 1) %>
        <%= live_component(__MODULE__.WordSoFar, tally: assigns.tally, id: 1) %>
      </div>
    """

  end
end
