defmodule Hangman.Runtime.Server do

  @type t :: pid
  use GenServer
  alias Hangman.Impl.Game
  # Called in the context of client
  def start_link(_) do
    GenServer.start_link(__MODULE__,nil)
  end


  def init(_args) do
    {:ok, Game.new_game }
  end

  def handle_call({:make_move, guess}, _from , game) do
    { updated_game, tally } =  Game.make_move(game, guess)
    { :reply, tally, updated_game }
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game }
  end

end