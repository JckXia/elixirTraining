defmodule B1Web.HangmanController do
  use B1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, __params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    conn
    |> put_session( :game, game)
    |> render("game.html", tally: tally)
  end

  def update(conn, params) do
    guess = params["make_move"]["guess"]
    game = get_session(conn, :game)
    tally = Hangman.make_move(game, guess)
    conn = put_in(conn.params["make_move"]["guess"], "")
    render(conn, "game.html", tally: tally)
  end
end
