defmodule Hangman.Runtime.Server do

  @type t :: pid
  @idle_timeout 1 * 60 * 60 * 1000
  use GenServer
  alias Hangman.Impl.Game
  alias Hangman.Runtime.Watchdog
  # Called in the context of client
  def start_link(_) do
    GenServer.start_link(__MODULE__,nil)
  end


  def init(_args) do
    watcher = Watchdog.start(@idle_timeout)
    {:ok, {Game.new_game, watcher}}
  end

  def handle_call({:make_move, guess}, _from , {game, watcher }) do
    Watchdog.im_alive(watcher)
    { updated_game, tally } =  Game.make_move(game, guess)
    { :reply, tally, {updated_game, watcher} }
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    {:reply, Game.tally(game), {game, watcher} }
  end

end
