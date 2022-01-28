defmodule B2Web.Live.Game.Alphabet do
  use B2Web, :live_component

  def mount(socket) do
    letters = (?a..?z) |> Enum.map(&<< &1 :: utf8>>)
    {:ok, assign(socket, :letters, letters)}
  end

    defp classOf(letter, tally) do
      cond do
        Enum.member?(tally.letters, letter) -> "correct"
        Enum.member?(tally.used,letter) -> "wrong"
        true -> ""
      end
    end
  def render(assigns) do
    ~H"""
    <div>
      <%= for letter <- assigns.letters do %>

        <%= letter %>
      <% end %>
    </div>
    """
  end
end
