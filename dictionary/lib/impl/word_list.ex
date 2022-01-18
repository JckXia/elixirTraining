defmodule Dictionary.Impl.WordList do

  @type t :: list(String.t)

  @spec word_list() :: t
  def word_list do
    "../assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
  end

  @spec random_words(t) :: String.t
  def random_words(words) do
    words
    |> Enum.random()
  end
end
