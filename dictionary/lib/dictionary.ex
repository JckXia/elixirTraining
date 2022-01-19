
#Every function body is responsible for just a single trans

# new_game creates a new state. Game returns a token to the client that represents this state

# The token is the actual state.
# Treating state as opaque value outside the implementation uses it

# Once client has token, it passes it to successive API calls. API is responsible for reconsituting its internal state


# The "assets/words.txt" file gets loaded at compile time via the annotatio.integer()

# start() is used to read in the word list.integer()
# return the state of the dictionary
defmodule Dictionary  do

  alias Dictionary.Runtime.Server

  @opaque t :: Server.t

  @spec start_link() :: {:ok, t }
  defdelegate start_link, to: Server, as: :start_link

  @spec random_word() :: String.t
  defdelegate random_word(), to: Server, as: :random_word

end

defmodule Procs do
  def hello(count) do
    receive do
      { :crash , reason } ->
        exit(reason)
      {:reset } -> hello(0)
      {:quit } -> IO.puts("Process exit")
      {:add, n} -> hello(count + n)
       msg->
        # code
        IO.puts("hello #{count}, #{inspect msg}")
        hello(count)
    end
  end

end

defmodule Chain do

  defstruct(
    next_node: nil,
    count: 4
  )

  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [%Chain{next_node: next_node}] )
    |> Process.register(:chainer)
  end

  def message_loop(%{count: 0 }) do
    IO.puts("Done")
  end

  def message_loop(state) do
    receive do
      {:trigger, list } ->
        IO.inspect list
        :timer.sleep 500
        send {:chainer, state.next_node }, { :trigger, [node() | list ] }
    end
    message_loop(%{ state | count: state.count - 1 })
  end

end
