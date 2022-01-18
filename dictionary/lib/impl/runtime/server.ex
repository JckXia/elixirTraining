defmodule Dictionary.Runtime.Server do

  @type t :: pid()
  @me :wilma
  alias Dictionary.Impl.WordList

  use Agent

  def start_link(_arg) do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  def random_word() do

    # if :rand.uniform < 0.33 do
    #   Agent.get(@me, fn _ -> exit(:boom) end)
    # end

    Agent.get(@me, &WordList.random_words/1)
  end

end
