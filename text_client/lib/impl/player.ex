defmodule TextClient.Impl.Player do


  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: { game, tally }

  # @typep state :: { game, tally }

  @spec start() ::  :ok
  def start() do
    game = Hangman.new_game
    tally = Hangman.tally(game)
    interact({ game, tally})
  end


  @spec interact(state) :: :ok
  def interact({game, tally}) do
    IO.puts feedback_for(tally)
    # feedback
    # display current word
    # get next guess
    # make a move
    # interact()
  end

  def feedback_for(tally = %{ game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length } letter word"
  end

  def feedback_for(%{game_state: :good_guess}), do: "Good guess"
  def feedback_for(%{game_state: :bad_guess}), do: "Letter not used"
  def feedback_for(%{game_state: :already_used}), do: "letter alread used in the letter"



  def interact({ _game, _tally = %{ game_state: :won }}) do
    IO.puts "Congrats, you've won!"
  end

  def interact({ _game, tally = %{ game_state: :lost }}) do
    IO.puts "Sorry, you've lost! The word was #{tally.letters |> Enum.join}"
  end


end
