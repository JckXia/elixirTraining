defmodule Dictionary.Runtime.Server do

  @type t :: pid()
  @me :wilma
  alias Dictionary.Impl.WordList
  def start_link do
    {:ok , pid} = Agent.start_link(&WordList.word_list/0, name: @me)
  end

  def random_word() do
    Agent.get(@me, &WordList.random_words/1)
  end

end
