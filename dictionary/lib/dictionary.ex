
#Every function body is responsible for just a single trans

# new_game creates a new state. Game returns a token to the client that represents this state

# The token is the actual state.
# Treating state as opaque value outside the implementation uses it

# Once client has token, it passes it to successive API calls. API is responsible for reconsituting its internal state


# The "assets/words.txt" file gets loaded at compile time via the annotatio.integer()

# start() is used to read in the word list.integer()
# return the state of the dictionary
defmodule Dictionary  do

  alias Dictionary.Impl.WordList


  defdelegate start, to: WordList, as: :word_list

  defdelegate random_words(words), to: WordList

end

# defmodule Lists do
#   def len([]), do: 0

#   def len([h|t]), do: h + len(t)

#   def double([]), do: []
#   def double([head | tail]), do: [2 * head | double(tail)]

#   def square([]), do: []
#   def square([head | tail]), do: [ head * head | square(tail)]

#   def sum_pairs([]), do: []
#   def sum_pairs([h1,h2 | t]), do: [h1+h2 | sum_pairs(t) ]

#   def even_length([]), do: true
#   def even_length([h]), do: false
#   def even_length([h | t]), do: h && !even_length(t)

# end
