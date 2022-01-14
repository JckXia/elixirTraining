defmodule HangmanImplTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game return correct state" do
    game = Game.new_game
    assert game.turns_left === 7
    assert game.game_state === :initializing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = Game.new_game("wombat")
    assert game.turns_left === 7
    assert game.game_state === :initializing
    assert game.letters === ["w","o","m","b","a","t"]
  end

  test "state doesnt change if gamee is won " do
    for state <- [:won, :lost ] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, state)
      { new_game, _tally } = Game.make_move(game, "x")
      assert new_game === game
    end
  end

  test "a duplicated letter is reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state === :already_used

  end

  test "We record letter used " do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")

    assert MapSet.equal?(game.used, MapSet.new(["x","y"]))
  end

test "we recongnize a letter in the word" do
  game = Game.new_game("wombat")
  { game, tally } =Game.make_move(game, "w")
  assert tally.game_state === :good_guess

  { game, tally } = Game.make_move(game, "t")
  assert tally.game_state === :good_guess

end


test "we recongnize a letter  not in the word" do
  game = Game.new_game("wombat")
  { game, tally } =Game.make_move(game, "x")
  assert tally.game_state === :bad_guess

  { game, tally } =Game.make_move(game, "w")
  assert tally.game_state === :good_guess

  { game, tally } =Game.make_move(game, "y")
  assert tally.game_state === :bad_guess
end

test "Can handle a sequence of moves" do
  # hello
[
  # guess #result  #t_left #letters         #letters used
  ["a", :bad_guess, 6, ["_","_","_","_","_"], ["a"]],
  ["a", :already_used, 6, ["_","_","_","_","_"], ["a"]],
  ["e", :good_guess, 6, ["_","e","_","_","_"], ["a","e"]],
  ["x", :bad_guess,5, ["_","e","_","_","_"], ["a","e","x"]]
]  |> test_seq_of_moves()
end

defp test_seq_of_moves(script) do
  game = Game.new_game("hello")
  Enum.reduce(script, game, &check_one_move/2)
end

defp check_one_move([guess, state, turns, letters, used], game) do
 { game, tally} = Game.make_move(game, guess)
  assert tally.game_state === state
  assert tally.turns_left === turns
  assert tally.letters === letters
  assert tally.used === used
  game
end

end
