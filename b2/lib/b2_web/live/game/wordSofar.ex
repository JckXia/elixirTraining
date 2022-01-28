defmodule B2Web.Live.Game.WordSoFar do
  use B2Web, :live_component

  @states %{
    already_used: "You've already picked that letter",
    bad_guess: "That's not in the word",
    good_guess: "Good guess",
    initializing: "Type or click on your first guess",
    lost: "Sorry mate, you lost",
    won: "Wee congrats!"
  }
  def mount(socket) do
    {:ok, socket}
  end

  defp state_name(state) do
    @states[state] || "Unknown state"
  end

  def render(assigns) do
    ~H"""
    <div class="word-so-far">
    <div class="turns_left">
     Turns left: <%= @tally.turns_left %>
    </div>
    <div class="game-state">
      <%= @tally.game_state |> state_name %>
    </div>
    <div class="letters">
      <%= for ch <- @tally.letters do %>
         <%= ch %>
      <% end %>
    </div>
    </div>
    """
  end
end
