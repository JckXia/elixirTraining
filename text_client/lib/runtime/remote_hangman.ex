defmodule TextClient.Runtime.RemoteHangman do

  @remote_server :"hangman@jxia-C02VN1AJHV2R"
  def connect() do
    :rpc.call(@remote_server, Hangman, :new_game,[])
  end

end
