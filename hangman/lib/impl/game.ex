defmodule Hangman.Impl.Game do

  @type t :: %Hangman.Impl.Game{
    turns_left: integer,
    game_state: Hangman.state,
    letters: list(String.t),
    used: MapSet.t(String.t),
  }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  # Internal data structure
  # number of turns left, letters of words guessed so far
  def new_game do
    %Hangman.Impl.Game{
      letters: Dictionary.random_word |>String.codepoints
    }
  end



end
